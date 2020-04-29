Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15E41BDB39
	for <lists+linux-arch@lfdr.de>; Wed, 29 Apr 2020 13:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgD2L7E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Apr 2020 07:59:04 -0400
Received: from foss.arm.com ([217.140.110.172]:37796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgD2L7E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Apr 2020 07:59:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5768D1063;
        Wed, 29 Apr 2020 04:59:03 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C98633F73D;
        Wed, 29 Apr 2020 04:59:01 -0700 (PDT)
Date:   Wed, 29 Apr 2020 12:58:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kevin Brodsky <kevin.brodsky@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 20/23] fs: Allow copy_mount_options() to access
 user-space in a single pass
Message-ID: <20200429115858.GA10651@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-21-catalin.marinas@arm.com>
 <9544d86b-d445-3497-fbbf-56c590400f83@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9544d86b-d445-3497-fbbf-56c590400f83@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 28, 2020 at 07:16:29PM +0100, Kevin Brodsky wrote:
> On 21/04/2020 15:26, Catalin Marinas wrote:
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index a28e4db075ed..8febc50dfc5d 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -3025,13 +3025,16 @@ void *copy_mount_options(const void __user * data)
> >   	if (!copy)
> >   		return ERR_PTR(-ENOMEM);
> > -	size = PAGE_SIZE - offset_in_page(data);
> > +	size = PAGE_SIZE;
> > +	if (!arch_has_exact_copy_from_user(size))
> > +		size -= offset_in_page(data);
> > -	if (copy_from_user(copy, data, size)) {
> > +	if (copy_from_user(copy, data, size) == size) {
> >   		kfree(copy);
> >   		return ERR_PTR(-EFAULT);
> >   	}
> >   	if (size != PAGE_SIZE) {
> > +		WARN_ON(1);
> 
> I'm not sure I understand the rationale here. If we don't have exact
> copy_from_user for size, then we will attempt to copy up to the end of the
> page. Assuming this doesn't fault, we then want to carry on copying from the
> start of the next page, until we reach a total size of up to 4K. Why would
> we warn in that case? AIUI, if you don't have exact copy_from_user, there
> are 3 cases:
> 1. copy_from_user() returns size, we bail out.
> 2. copy_from_user() returns 0, we carry on copying from the next page.
> 3. copy_from_user() returns anything else, we return immediately.
> 
> I think you're not handling case 3 here.

(3) is still handled as (2) since the only check we have is whether
copy_from_user() returned size. Since size is not updated, it falls
through the second if block (where WARN_ON should have disappeared).

Thinking some more about this, I think it can be simplified without
adding arch_has_exact_copy_from_user(). We do have to guarantee on arm64
that a copy_from_user() to the end of a page (4K aligned, hence tag
granule aligned) is exact but that's just matching the current
semantics.

What about this new patch below, replacing the current one:

-------------8<-------------------------------
From cf9a1c9668ce77af3ef6589ee8038e91df127dab Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 15 Apr 2020 18:45:44 +0100
Subject: [PATCH] fs: Handle intra-page faults in copy_mount_options()

The copy_mount_options() function takes a user pointer argument but no
size. It tries to read up to a PAGE_SIZE. However, copy_from_user() is
not guaranteed to return all the accessible bytes if, for example, the
access crosses a page boundary and gets a fault on the second page. To
work around this, the current copy_mount_options() implementation
performs two copy_from_user() passes, first to the end of the current
page and the second to what's left in the subsequent page.

On arm64 with MTE enabled, access to a user page may trigger a fault
after part of the buffer has been copied (when the user pointer tag,
bits 56-59, no longer matches the allocation tag stored in memory).
Allow copy_mount_options() to handle such case by only returning -EFAULT
if the first copy_from_user() has not copied any bytes.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Will Deacon <will@kernel.org>
---
 fs/namespace.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a28e4db075ed..51eecbd8ea89 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3016,7 +3016,7 @@ static void shrink_submounts(struct mount *mnt)
 void *copy_mount_options(const void __user * data)
 {
 	char *copy;
-	unsigned size;
+	unsigned size, left;
 
 	if (!data)
 		return NULL;
@@ -3027,11 +3027,22 @@ void *copy_mount_options(const void __user * data)
 
 	size = PAGE_SIZE - offset_in_page(data);
 
-	if (copy_from_user(copy, data, size)) {
+	/*
+	 * Attempt to copy to the end of the first user page. On success,
+	 * left == 0, copy the rest from the second user page (if it is
+	 * accessible).
+	 *
+	 * On architectures with intra-page faults (arm64 with MTE), the read
+	 * from the first page may fail after copying part of the user data
+	 * (left > 0 && left < size). Do not attempt the second copy in this
+	 * case as the end of the valid user buffer has already been reached.
+	 */
+	left = copy_from_user(copy, data, size);
+	if (left == size) {
 		kfree(copy);
 		return ERR_PTR(-EFAULT);
 	}
-	if (size != PAGE_SIZE) {
+	if (left == 0 && size != PAGE_SIZE) {
 		if (copy_from_user(copy + size, data + size, PAGE_SIZE - size))
 			memset(copy + size, 0, PAGE_SIZE - size);
 	}
