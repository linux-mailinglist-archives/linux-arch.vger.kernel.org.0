Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264DD1BCC83
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 21:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgD1TkL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 15:40:11 -0400
Received: from foss.arm.com ([217.140.110.172]:58232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728392AbgD1TkK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 15:40:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E5C5C14;
        Tue, 28 Apr 2020 12:40:10 -0700 (PDT)
Received: from C02TF0J2HF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE6B73F68F;
        Tue, 28 Apr 2020 12:40:05 -0700 (PDT)
Date:   Tue, 28 Apr 2020 20:40:01 +0100
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
Message-ID: <20200428194001.GB35158@C02TF0J2HF1T.local>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-21-catalin.marinas@arm.com>
 <9544d86b-d445-3497-fbbf-56c590400f83@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9544d86b-d445-3497-fbbf-56c590400f83@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 28, 2020 at 07:16:29PM +0100, Kevin Brodsky wrote:
> On 21/04/2020 15:26, Catalin Marinas wrote:
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index 32fc8061aa76..566da441eba2 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -416,6 +416,17 @@ extern unsigned long __must_check __arch_copy_in_user(void __user *to, const voi
> >   #define INLINE_COPY_TO_USER
> >   #define INLINE_COPY_FROM_USER
> > +static inline bool arch_has_exact_copy_from_user(unsigned long n)
> > +{
> > +	/*
> > +	 * copy_from_user() aligns the source pointer if the size is greater
> > +	 * than 15. Since all the loads are naturally aligned, they can only
> > +	 * fail on the first byte.
> > +	 */
> > +	return n > 15;
> > +}
> > +#define arch_has_exact_copy_from_user
> > +
> >   extern unsigned long __must_check __arch_clear_user(void __user *to, unsigned long n);
> >   static inline unsigned long __must_check __clear_user(void __user *to, unsigned long n)
> >   {
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
> we warn in that case?

We shouldn't warn, thanks for spotting this. I added it for some testing
and somehow ended up in the commit.

-- 
Catalin
