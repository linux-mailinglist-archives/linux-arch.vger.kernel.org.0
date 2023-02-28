Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC96A5B9B
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 16:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjB1PWm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 10:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjB1PWl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 10:22:41 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7699630B1E;
        Tue, 28 Feb 2023 07:22:38 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id m22so3771156ioy.4;
        Tue, 28 Feb 2023 07:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrCu0geLOi4OVGkwEDjMoWqOD6knh9EFuIYJINwxG2Q=;
        b=IGBBoowU11kDoWvFa5UzxduFuKkleISEIsB8g0SLdw3lG87SsG8+PsmkrCrm3TH2pt
         LBN/n5AsWe0dZ2AIgADeF8KWpj+ycPcePDpjwLCg0T63e6K3XjzdEZXIUgV6TE7WUBN1
         AK2CARlsdEe/OX1TbsU78oHzkcJn1RVW+c7oYGgocxiBXOe8c+dQkbo6AMBYWCYSeWRC
         vhMfw47fslKk3wVgBClGFXE6FBNXcORvFJZL+8l11ZidzustABk5nGG0x2gpRfO9RxJD
         PuL/N5Cl9Ya1t3fGA7nJ+DSi9olydAlsnnYP9GKF7V1L+IZjLHdL2hpD/GalkWFZw9V7
         1jRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrCu0geLOi4OVGkwEDjMoWqOD6knh9EFuIYJINwxG2Q=;
        b=jOBsKVirr/3yIR6gowy3t15UWf1tl/jTsNjT1JoZWK6nkfdE+s1M9jUMIczu3wvkd3
         urpoWC5/oS+Geub5ASRANQiJfmC7IauzWxSObtp5AIZjouRuNOF7HFftNcL4gIxvJreq
         GK62n8zMlbbwYESSfUoNSt2ykR3vmHVQLe8+RUFmJZmEDB6JOLZkdndCOy9Pv0eFP763
         hgagZB8Ad+AUGuZzw6ZkPKJ6or4ITI/17vd+IkAPMQQxLNHTsTo2RV1ecDx/CZYSvqrS
         glK8FzqsXEuUwma5JwEBQDjrI7vG7qbntl/MdGJawPLuOmc1/6lPSmlclqtl057dJuZK
         xkzQ==
X-Gm-Message-State: AO0yUKXi2AJgS+OHJulxKyriSGTRmpzZyRhuR6pvvURwHmFxj8k+fKF9
        p0E9DDPHEUYK6B7Q8XVFC6o=
X-Google-Smtp-Source: AK7set+LdpBxgFLhGrJy0C3vaLPK+VEhjyTfN5z2xzeOHwePBtyBs6X9Ur4LvLgcB2HwBRmMy6YJhg==
X-Received: by 2002:a05:6602:210b:b0:717:ce6a:188a with SMTP id x11-20020a056602210b00b00717ce6a188amr1936244iox.18.1677597757839;
        Tue, 28 Feb 2023 07:22:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b18-20020a056602001200b0073f0832050bsm3130445ioa.18.2023.02.28.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:22:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 28 Feb 2023 07:22:36 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 08/10] parisc: fix livelock in uaccess
Message-ID: <20230228152236.GA4088022@roeck-us.net>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <Y9l0w4M91DwYLO3N@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9l0w4M91DwYLO3N@ZenIV>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 31, 2023 at 08:06:27PM +0000, Al Viro wrote:
> parisc equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
> If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
> end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
> to page tables.  In such case we must *not* return to the faulting insn -
> that would repeat the entire thing without making any progress; what we need
> instead is to treat that as failed (user) memory access.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/parisc/mm/fault.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
> index 869204e97ec9..bb30ff6a3e19 100644
> --- a/arch/parisc/mm/fault.c
> +++ b/arch/parisc/mm/fault.c
> @@ -308,8 +308,11 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
>  
>  	fault = handle_mm_fault(vma, address, flags, regs);
>  
> -	if (fault_signal_pending(fault, regs))
> +	if (fault_signal_pending(fault, regs)) {
> +		if (!user_mode(regs))
> +			goto no_context;

0-day rightfully complains that this leaves 'msg' uninitialized.

arch/parisc/mm/fault.c:427 do_page_fault() error: uninitialized symbol 'msg'

Guenter

>  		return;
> +	}
>  
>  	/* The fault is fully completed (including releasing mmap lock) */
>  	if (fault & VM_FAULT_COMPLETED)
