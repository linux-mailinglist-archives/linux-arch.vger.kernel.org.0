Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D518433A81D
	for <lists+linux-arch@lfdr.de>; Sun, 14 Mar 2021 22:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhCNVDd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Mar 2021 17:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhCNVD3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Mar 2021 17:03:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1EDC061574
        for <linux-arch@vger.kernel.org>; Sun, 14 Mar 2021 14:03:29 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lLXtP-00G7qC-SZ; Sun, 14 Mar 2021 22:03:20 +0100
Message-ID: <d357fbd075319d8b32667323bc545e3e5e8e8a21.camel@sipsolutions.net>
Subject: Re: [RFC v8 00/20] Unifying LKL into UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Sun, 14 Mar 2021 22:03:19 +0100
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <cover.1611103406.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

So I'm still a bit lost here with this, and what exactly you're doing in
places.

For example, you simulate a single CPU ("depends on !SMP", and anyway
UML only supports that right now), yet on the other hand do a *LOT* of
extra work with lkl_sem, lkl_thread, lkl_mutex, and all that. It's not
clear to me why? Are you trying to model kernel threads as actual
userspace pthreads, but then run only one at a time by way of exclusive
locking?

I think we probably need a bit more architecture introduction here in
the cover letter or the documentation patch. The doc patch basically
just explains what it does, but not how it does anything, or why it was
done in this way.

For example, I'm asking myself:
 * Why NOMMU? UML doesn't really do _much_ with memory protection unless
   you add userspace, which you don't have.
 * Why pthreads and all? You already require jump_buf, so UML's
   switch_threads() ought to be just fine for scheduling? It almost
   seems like you're doing this just so you can serialize against "other
   threads" (application threads), but wouldn't that trivially be
   handled by the application? You could let it hook into switch_to() or
   something, but why should a single "LKL" CPU ever require multiple
   threads? Seems to me that the userspace could be required to
   "lkl_run()" or so (vs. lkl_start()). Heck, you could even exit
   lkl_run() every time you switch tasks in the kernel, and leave
   scheduling the kernel vs. the application entirely up to the
   application? (A trivial application would be simply doing something
   like "while (1) { lkl_run(); pause(); }" mimicking the idle loop of
   UML.

And - kind of the theme behind all these questions - why is this not
making UML actually be a binary that uses LKL? If the design were like
what I'm alluding to above, that should actually be possible? Why should
it not be possible? Why would it not be desirable? (I'm actually
thinking that might be really useful to some of the things I'm doing.)
Yes, if the application actually supports userspace running then it has
som limitations on what it can do (in particular wrt. signals etc.), but
that could be documented and would be OK?

johannes

