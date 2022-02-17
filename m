Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78D84BA9CC
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 20:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245183AbiBQT3c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 14:29:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiBQT3c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 14:29:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3DE129BB2;
        Thu, 17 Feb 2022 11:29:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD70A61CFC;
        Thu, 17 Feb 2022 19:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37C5C340E8;
        Thu, 17 Feb 2022 19:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645126156;
        bh=kHigbTssltdpECsVACXjUmCjoYc8nJe1TohCmnF/uDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0uHw0H9e1BKIXKJ2/u7FYUc5Y24CS+0asyxuvN2f7vHivb+GQMOmznT82N8OROTl
         ciHE8TSSR3HCcxH1cGTveCtkMFi00xnkQIuCZGRvpvN4TDSGie2q4rtWDyUu6b8fyb
         CpZGKfeAyYH2IRlf3sjYb6ycq76erMuPHJklVVz4=
Date:   Thu, 17 Feb 2022 20:29:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [RFC PATCH 01/13] list: introduce speculative safe
 list_for_each_entry()
Message-ID: <Yg6iCS0XZB6EtMP7@kroah.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-2-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217184829.1991035-2-jakobkoschel@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 17, 2022 at 07:48:17PM +0100, Jakob Koschel wrote:
> list_for_each_entry() selects either the correct value (pos) or a safe
> value for the additional mispredicted iteration (NULL) for the list
> iterator.
> list_for_each_entry() calls select_nospec(), which performs
> a branch-less select.
> 
> On x86, this select is performed via a cmov. Otherwise, it's performed
> via various shift/mask/etc. operations.
> 
> Kasper Acknowledgements: Jakob Koschel, Brian Johannesmeyer, Kaveh
> Razavi, Herbert Bos, Cristiano Giuffrida from the VUSec group at VU
> Amsterdam.
> 
> Co-developed-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  arch/x86/include/asm/barrier.h | 12 ++++++++++++
>  include/linux/list.h           |  3 ++-
>  include/linux/nospec.h         | 16 ++++++++++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index 35389b2af88e..722797ad74e2 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -48,6 +48,18 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
>  /* Override the default implementation from linux/nospec.h. */
>  #define array_index_mask_nospec array_index_mask_nospec
>  
> +/* Override the default implementation from linux/nospec.h. */
> +#define select_nospec(cond, exptrue, expfalse)				\
> +({									\
> +	typeof(exptrue) _out = (exptrue);				\
> +									\
> +	asm volatile("test %1, %1\n\t"					\
> +	    "cmove %2, %0"						\
> +	    : "+r" (_out)						\
> +	    : "r" (cond), "r" (expfalse));				\
> +	_out;								\
> +})
> +
>  /* Prevent speculative execution past this barrier. */
>  #define barrier_nospec() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
>  
> diff --git a/include/linux/list.h b/include/linux/list.h
> index dd6c2041d09c..1a1b39fdd122 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -636,7 +636,8 @@ static inline void list_splice_tail_init(struct list_head *list,
>   */
>  #define list_for_each_entry(pos, head, member)				\
>  	for (pos = list_first_entry(head, typeof(*pos), member);	\
> -	     !list_entry_is_head(pos, head, member);			\
> +	    ({ bool _cond = !list_entry_is_head(pos, head, member);	\
> +	     pos = select_nospec(_cond, pos, NULL); _cond; }); \
>  	     pos = list_next_entry(pos, member))
>  

You are not "introducing" a new macro for this, you are modifying the
existing one such that all users of it now have the select_nospec() call
in it.

Is that intentional?  This is going to hit a _lot_ of existing entries
that probably do not need it at all.

Why not just create list_for_each_entry_nospec()?

thanks,

greg k-h
