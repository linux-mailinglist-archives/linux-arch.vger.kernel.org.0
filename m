Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090FD5759DB
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jul 2022 05:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiGODNQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Jul 2022 23:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiGODNQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jul 2022 23:13:16 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A052CC91;
        Thu, 14 Jul 2022 20:13:15 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 23so3273293pgc.8;
        Thu, 14 Jul 2022 20:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0kNvzHNczTALecfT9wto6CsS50awskOSoxCbfvaNPgc=;
        b=d6rOttoave+cYYycQLZVtn7+6/EvvZMoC4KlEKnu5+Iy0CvIZB6RZvM+yDNYgjVsg2
         zExWP1Kt2mvHL2caS42uLQwLfFdIGT+vt+VNkOv6EFVEz1IJ1Ei1z/SUwomvWvL9yqs/
         LsfjR3vwcHDm1bfvDdBsjVXVCIzYFoJ6KMcatcAC61WXc2/vMcOjiKCXnv0z+ZYpPW1D
         29300GYk48m1QvWYlTwrWUJ2ga8Ap1QJw6DN92YdxZnF6aT4PwJr+48L7OzWyifSHnIo
         bBliGjA2A7iI1JHvd2yG0VTITazqxx3xOm38zhCb9ZIUiYeXEPs2TlvdcILgJvPCljIq
         R2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0kNvzHNczTALecfT9wto6CsS50awskOSoxCbfvaNPgc=;
        b=QN1KHrm48rAJD5fzBNOgZjhfCzLL8XI17G9WwVqedi0xmXJr+o4BaGjxNFXWcshhUC
         CmHS6PrTCfGBrnbZ9z4vGHmXJ+SL//YgSGSzEtX6lBI19hHyXLtjSBs9HctMfkGtO8ml
         0X9hX9AlLkBpQXtn1QQ5jdSmNs+WGL0Jk1Lk3arotJV5+ANfLEgRLd7sS7cRoK04QdK5
         b3hxuKptjV7JNBQnFwgpsHI5UcaJeOqyfLIA1IDX2EmNzpCp490SxVhvM69ihquIZeOd
         rPXrHv86Nkbp/d28j3C/DMopZHJJHhmRfkIGHsxWayrIdb6LHd94G3taAg8koCq+59N7
         L0+Q==
X-Gm-Message-State: AJIora/SCLgVhagKduoZ2Bldj4py96FUWu4qtip08JTEn/nvRD2iAyXq
        /rHgr7ZE3NSmYeZkhSv0VcQ+s5MPcxY=
X-Google-Smtp-Source: AGRyM1vK5uqkhNs5DYoiUnUKiOfj2RRKOpP4xHProAEOYr/w1Br1ZQPpNcitPwDkSe+/qgFCXMCFZg==
X-Received: by 2002:a63:2051:0:b0:412:6d61:ab0a with SMTP id r17-20020a632051000000b004126d61ab0amr10627004pgm.52.1657854794876;
        Thu, 14 Jul 2022 20:13:14 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b0016c6a6d8967sm2236563plh.83.2022.07.14.20.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 20:13:14 -0700 (PDT)
Message-ID: <d95d1afe-655c-3526-0c7e-949dfad8c6ba@gmail.com>
Date:   Thu, 14 Jul 2022 20:13:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH V12 01/20] uapi: simplify __ARCH_FLOCK{,64}_PAD a little
Content-Language: en-US
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, hch@lst.de, nathan@kernel.org,
        naresh.kamboju@linaro.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        heiko@sntech.de
References: <20220405071314.3225832-1-guoren@kernel.org>
 <20220405071314.3225832-2-guoren@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220405071314.3225832-2-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 4/5/2022 12:12 AM, guoren@kernel.org wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Don't bother to define the symbols empty, just don't use them.
> That makes the intent a little more clear.
> 
> Remove the unused HAVE_ARCH_STRUCT_FLOCK64 define and merge the
> 32-bit mips struct flock into the generic one.
> 
> Add a new __ARCH_FLOCK_EXTRA_SYSID macro following the style of
> __ARCH_FLOCK_PAD to avoid having a separate definition just for
> one architecture.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Being late to this, but this breaks the perf build for me using a MIPS 
toolchain with the following:

   CC 
/home/fainelli/work/buildroot/output/bmips/build/linux-custom/tools/perf/trace/beauty/fcntl.o
In file included from 
../../../../host/mipsel-buildroot-linux-gnu/sysroot/usr/include/asm/fcntl.h:77,
                  from ../include/uapi/linux/fcntl.h:5,
                  from trace/beauty/fcntl.c:10:
../include/uapi/asm-generic/fcntl.h:188:8: error: redefinition of 
'struct flock'
  struct flock {
         ^~~~~
In file included from ../include/uapi/linux/fcntl.h:5,
                  from trace/beauty/fcntl.c:10:
../../../../host/mipsel-buildroot-linux-gnu/sysroot/usr/include/asm/fcntl.h:63:8: 
note: originally defined here
  struct flock {
         ^~~~~
make[6]: *** 
[/home/fainelli/work/buildroot/output/bmips/build/linux-custom/tools/build/Makefile.build:97: 
/home/fainelli/work/buildroot/output/bmips/build/linux-custom/tools/perf/trace/beauty/fcntl.o] 
Error 1

the kernel headers are set to 4.1.31 which is arguably old but 
toolchains using newer kernel headers do not fare much better either 
unfortunately as I tried a toolchain with kernel headers 4.9.x.

I will start doing more regular MIPS builds of the perf tools since that 
seems to escape our testing.

Thanks!
-- 
Florian
