Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B604602696
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 10:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJRIQ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Oct 2022 04:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiJRIQZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Oct 2022 04:16:25 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0321D923D1;
        Tue, 18 Oct 2022 01:16:24 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id t16so109751edd.2;
        Tue, 18 Oct 2022 01:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCEP93SrKha1beFcHYoSoxHTQfYCss+8LIPY1BuUnHo=;
        b=q3vJyV6Iu6H5Nfm5mwemw1IHPhpRyCDJszYNlHPPoNDvADDEM30Jg4cgXRT41AhtKN
         aFeGiSQNXdm8a7TmnBw6XkvTR9gF+n4mAEwhBg3YQIThBh8LXRp3CgSVU3l2xo+zIgx0
         RXCoAywjsLpHn+sxcA3+AUxYqN7zwjNmBJB1OIOheTtc0P4n3z+UYbjMpjCMoGu8t7wE
         8PVO+3+YOKAFIKFDyhYF/zZSEKhswG1v5REr5qNSS1fNY5hMLLqHpfbudQu3g/i8ND6I
         k3+YU4FUtp+rCNLDhOZRfZ+spTo+bcwsK9XBWoerTVLCJXxCFtd9HqdOMj93eCjuDktD
         eifA==
X-Gm-Message-State: ACrzQf3iS1sMHK59xVoc+chtNAGHcqc9fqG/nUcC1uVxiNZa9EiADrh6
        vYXwgKRB+9IQYNXZO94/p81MBVsNsYf41w==
X-Google-Smtp-Source: AMsMyM5iFP5RWjGsIwbkTbMz/UTSCNAYrf3Yt0ooQaRGisC/dUpdEwciNE+Z1xcroG4uunAuqakRzA==
X-Received: by 2002:a05:6402:414f:b0:456:c2c1:23ec with SMTP id x15-20020a056402414f00b00456c2c123ecmr1566020eda.420.1666080982491;
        Tue, 18 Oct 2022 01:16:22 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b0073d5948855asm7249938ejo.1.2022.10.18.01.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 01:16:21 -0700 (PDT)
Message-ID: <1ec14007-affc-f826-6dda-f23ee166226a@kernel.org>
Date:   Tue, 18 Oct 2022 10:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 7/7] kbuild: remove head-y syntax
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-8-masahiroy@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220924181915.3251186-8-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 24. 09. 22, 20:19, Masahiro Yamada wrote:
> Kbuild puts the objects listed in head-y at the head of vmlinux.
> Conventionally, we do this for head*.S, which contains the kernel entry
> point.
> 
> A counter approach is to control the section order by the linker script.
> Actually, the code marked as __HEAD goes into the ".head.text" section,
> which is placed before the normal ".text" section.
> 
> I do not know if both of them are needed. From the build system
> perspective, head-y is not mandatory. If you can achieve the proper code
> placement by the linker script only, it would be cleaner.
> 
> I collected the current head-y objects into head-object-list.txt. It is
> a whitelist. My hope is it will be reduced in the long run.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
...
> --- a/Makefile
> +++ b/Makefile
> @@ -1149,10 +1149,10 @@ quiet_cmd_ar_vmlinux.a = AR      $@
>         cmd_ar_vmlinux.a = \
>   	rm -f $@; \
>   	$(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
> -	$(AR) mPiT $$($(AR) t $@ | head -n1) $@ $(head-y)
> +	$(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F --file=$(srctree)/scripts/head-object-list.txt)

With AR=gcc-ar, the "| head -n1" results in:
/usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-linux/bin/ar 
terminated with signal 13 [Broken pipe]

I found out only with gcc-lto. But maybe we should make it silent in any 
case? I'm not sure how. This looks ugly (and needs the whole output to 
be piped):
gcc-ar t vmlinux.a | ( head -n1; cat >/dev/null )

Note the result appears to be correct, it's only that gcc-ar complains 
after printing out the very first line.

thanks,
-- 
js
suse labs

