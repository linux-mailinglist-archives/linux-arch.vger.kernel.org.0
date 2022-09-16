Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268335BB2E1
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 21:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiIPTkk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIPTkj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 15:40:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7531251A14
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 12:40:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q3so22012584pjg.3
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vH9TYUFkIGeMDXb5QksQYPq2h16Z8OyKOOQMeyEvl7I=;
        b=yQYnZNYXV2FOBIibg997hqy6cC66Xcky9Sj1dsdt9zQ2ExgJBmCw7m7HEVew01OMsq
         F5Syd9PMYleHHa8qZTq3Fm9U8YYRdzBT6XwXkLH6AkBSRD4kYLWXSbmA+XE0Ijd7Y02R
         fywzlhmHsq9NLj5EqW7MBVPTfeuC0m1PXQXy01iqcDPQ5fpf2SfP9VjvqQG43JPfEMzd
         THexk1qxiNY3EdQ9PhS20kfWyFX+ybdJ8u7ZRMlpfyWhiuQGOrEOcL0pCG6Ph5f1NyCE
         rYM8RxnObeweJJ5wHVpXvCjsOKxxl4A9iZ4d9eqpD/xkB/ezV5oRZDFpQnnhCdNgRhRC
         Uehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vH9TYUFkIGeMDXb5QksQYPq2h16Z8OyKOOQMeyEvl7I=;
        b=odGU0cjtm4p10jdMPiCN8hB03rYH3tt07Q/cxBer0pjFIq0+Qr/dKF0v7+HDbxyRxg
         r1DV9Q+ze+zXqBkrh6NKsWK1RRmLDU/+/exwXNFRN37mQ8l25J3oUE1EFEoGrEVHScvY
         txZGXyCkcXYHTus0RUHMbpAMNi2cjSGjsnc4YV3Z9X+6KP5f1bCtOLlI0QlnEHU04b+j
         5T2jeK0fhJZ+0cna7yKVEiilxYOOdwkYhraU2yfsgbxoLCBOEhWhS8aBeX6wwBkn4YMJ
         Hy+JILIF5t+GR4F6/FClE1t6DsmOixKruTDZiA6QUSaZanMKO0G0K/QliL/7ZY/VJZdH
         V/TQ==
X-Gm-Message-State: ACrzQf0R1eIo0yeLdxNsVO0n95owH0iu5dDWIMfHefAI5LZ8UN0pKHB1
        nle/PQXAWicSvLJpH+WGmATzGA==
X-Google-Smtp-Source: AMsMyM7bBzN5wKpJ4/hmwedRCv3ia/zW3TzU2MrSu2w0889ImAiNQlhDbVHcvxIyYWbaKNLMT5PpHA==
X-Received: by 2002:a17:90b:4c0c:b0:203:1407:809c with SMTP id na12-20020a17090b4c0c00b002031407809cmr7126292pjb.193.1663357237910;
        Fri, 16 Sep 2022 12:40:37 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:500::3:3c76])
        by smtp.gmail.com with ESMTPSA id c3-20020a170903234300b001780a528540sm15448988plh.93.2022.09.16.12.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:40:37 -0700 (PDT)
Date:   Fri, 16 Sep 2022 12:40:35 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] Discard .note.gnu.property sections in generic NOTES
Message-ID: <YyTRM3/9Mm+b+M8N@relinquished.localdomain>
References: <20200428132105.170886-1-hjl.tools@gmail.com>
 <20200428132105.170886-2-hjl.tools@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428132105.170886-2-hjl.tools@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 28, 2020 at 06:21:05AM -0700, H.J. Lu wrote:
> With the command-line option, -mx86-used-note=yes, the x86 assembler
> in binutils 2.32 and above generates a program property note in a note
> section, .note.gnu.property, to encode used x86 ISAs and features.  But
> kernel linker script only contains a single NOTE segment:
> 
> PHDRS {
>  text PT_LOAD FLAGS(5);
>  data PT_LOAD FLAGS(6);
>  percpu PT_LOAD FLAGS(6);
>  init PT_LOAD FLAGS(7);
>  note PT_NOTE FLAGS(0);
> }
> SECTIONS
> {
> ...
>  .notes : AT(ADDR(.notes) - 0xffffffff80000000) { __start_notes = .; KEEP(*(.not
> e.*)) __stop_notes = .; } :text :note
> ...
> }
> 
> The NOTE segment generated by kernel linker script is aligned to 4 bytes.
> But .note.gnu.property section must be aligned to 8 bytes on x86-64 and
> we get
> 
> [hjl@gnu-skx-1 linux]$ readelf -n vmlinux
> 
> Displaying notes found in: .notes
>   Owner                Data size Description
>   Xen                  0x00000006 Unknown note type: (0x00000006)
>    description data: 6c 69 6e 75 78 00
>   Xen                  0x00000004 Unknown note type: (0x00000007)
>    description data: 32 2e 36 00
>   xen-3.0              0x00000005 Unknown note type: (0x006e6558)
>    description data: 08 00 00 00 03
> readelf: Warning: note with invalid namesz and/or descsz found at offset 0x50
> readelf: Warning:  type: 0xffffffff, namesize: 0x006e6558, descsize:
> 0x80000000, alignment: 8
> [hjl@gnu-skx-1 linux]$
> 
> Since note.gnu.property section in kernel image is never used, this patch
> discards .note.gnu.property sections in kernel linker script by adding
> 
> /DISCARD/ : {
>   *(.note.gnu.property)
> }
> 
> before kernel NOTE segment in generic NOTES.
> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 71e387a5fe90..95cd678428f4 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -833,7 +833,14 @@
>  #define TRACEDATA
>  #endif
>  
> +/*
> + * Discard .note.gnu.property sections which are unused and have
> + * different alignment requirement from kernel note sections.
> + */
>  #define NOTES								\
> +	/DISCARD/ : {							\
> +		*(.note.gnu.property)					\
> +	}								\
>  	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
>  		__start_notes = .;					\
>  		KEEP(*(.note.*))					\
> -- 
> 2.25.4
> 

Hi, H.J.,

I recently ran into this same .notes corruption when building kernels on
Arch Linux.

What ended up happening to this patch? It doesn't appear to have been
merged, and I couldn't find any further discussion about it. I'm happy
to resend it for you if you need a hand.

Thanks,
Omar
