Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB5F73905E
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 21:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFUTq0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 15:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjFUTqZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 15:46:25 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267D21988
        for <linux-arch@vger.kernel.org>; Wed, 21 Jun 2023 12:46:23 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-66869feb7d1so3009400b3a.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Jun 2023 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687376782; x=1689968782;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yAEYX8p4xEPzztgSX6jBgXp6p/Xb2RUIX5fAtspxlsk=;
        b=O+py1+Rpcwp6w+AR4wey7NcLDxvddKtqNBonT+E2kowjbpXM93WK2d43d5Lo5eadvb
         i1DD8KpxveaNKlUarBlGyvv63EeTdAtgxwo23u1pgyTF7sMO2mlwVF04KbyxzEbx2IBq
         SVO7gg7973NHQ5PTrGDCCXBdnKUOJiIhuf0NTRX3jPr5EEE369JzQbXVvqwODDHVK80h
         H5vDaJf2v9Gcr8imIk5JdCHcKtI0UlFmWGXHvOMXroAd/7QvwD7ulLCMX3q7tP2dskCM
         GDPPpffLk6SXcGT+pZT3hWOQu6LHlBrT6Gd4QG7Dye4iUkxqC2t1+iztrMudIflP44WK
         oUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376782; x=1689968782;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAEYX8p4xEPzztgSX6jBgXp6p/Xb2RUIX5fAtspxlsk=;
        b=dG1pCpLLVYo50DY7LGRgU2EJCQqTa1s1dKtMwlYsavaazpe93PirZvXWrtob+18mf+
         A9trnPqSUGtCAtKGWf9JvEyQcju9tmVJgEJyChMSpD8zB83xIpUL5EjUA9LCFbk45Mk0
         AHKxu5eZ5NUFzv3Dc+3hqS5LpPsERSfilBNtp4wR1Y/jnt3ox9AMFD/N2chacoQdw55v
         UrWgS5q7QkORd0xwPDhTWcSPe05H+fN9L4RdXaYWNnMO3GVZ/inOaQ941bCsKH/XRYlt
         ydaNPP+vp57UFxzQjMI+/libRzljjaVJL2hpv9SJjJ9yNyNkbxhtCFVVoHSA1p/BhbqB
         0Y/Q==
X-Gm-Message-State: AC+VfDwZlkh47QpzAublJVGBQOguiYKkgxx/SQtLiSgrCMqoyCrSrlhh
        80uJMWxf74CETsH//rZatFhwU0e8/Z2sBaWoymU=
X-Google-Smtp-Source: ACHHUZ7++iionK3i1+rBjCBOM2BOzaovcT/5zgI9IHyrmKGBJktrKL9rdXh969Ib7fB+ucArnYBWvQ==
X-Received: by 2002:a05:6a20:13d9:b0:123:89f0:ec6b with SMTP id ho25-20020a056a2013d900b0012389f0ec6bmr1062014pzc.47.1687376782376;
        Wed, 21 Jun 2023 12:46:22 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id fe15-20020a056a002f0f00b006687f6727e1sm3222011pfb.206.2023.06.21.12.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:46:21 -0700 (PDT)
Date:   Wed, 21 Jun 2023 12:46:21 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Jun 2023 12:45:41 PDT (-0700)
Subject:     Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <mhng-1d790a82-44ad-4b9c-bfe4-6303f09b0705@palmer-ri-x1c9a>
CC:     bjorn@kernel.org, Conor Dooley <conor@kernel.org>,
        jszhang@kernel.org, llvm@lists.linux.dev,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ndesaulniers@google.com, nathan@kernel.org
Message-ID: <mhng-ad2d02fa-2d4d-4bf1-ab2a-fd84fa4bcb40@palmer-ri-x1c9a>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 21 Jun 2023 11:19:31 PDT (-0700), Palmer Dabbelt wrote:
> On Wed, 21 Jun 2023 10:51:15 PDT (-0700), bjorn@kernel.org wrote:
>> Conor Dooley <conor@kernel.org> writes:
>>
>> [...]
>>
>>>> So I'm no longer actually sure there's a hang, just something slow.
>>>> That's even more of a grey area, but I think it's sane to call a 1-hour
>>>> link time a regression -- unless it's expected that this is just very
>>>> slow to link?
>>>
>>> I dunno, if it was only a thing for allyesconfig, then whatever - but
>>> it's gonna significantly increase build times for any large kernels if LLD
>>> is this much slower than LD. Regression in my book.
>>>
>>> I'm gonna go and experiment with mixed toolchain builds, I'll report
>>> back..
>>
>> I took palmer/for-next (1bd2963b2175 ("Merge patch series "riscv: enable
>> HAVE_LD_DEAD_CODE_DATA_ELIMINATION"")) for a tuxmake build with llvm-16:
>>
>>   | ~/src/tuxmake/run -v --wrapper ccache --target-arch riscv \
>>   |     --toolchain=llvm-16 --runtime docker --directory . -k \
>>   |     allyesconfig
>>
>> Took forever, but passed after 2.5h.
>
> Thanks.  I just re-ran mine 17/trunk LLD under time (rather that just
> checking top sometimes), it's at 1.5h but even that seems quite long.
>
> I guess this is sort of up to the LLVM folks: if it's expected that DCE
> takes a very long time to link then I'm not opposed to allowing it, but
> if this is probably a bug in LLD then it seems best to turn it off until
> we sort things out over there.
>
> I think maybe Nick or Nathan is the best bet to know?

Looks like it's about 2h for me.  I'm going to drop these from my 
staging tree in the interest of making progress on other stuff, but if 
this is just expected behavior them I'm OK taking them (though that's 
too much compute for me to test regularly):

$ time ../../../../llvm/install/bin/ld.lld -melf64lriscv -z noexecstack -r -o vmlinux.o --whole-archive vmlinux.a --no-whole-archive --start-group ./drivers/firmware/efi/libstub/lib.a --end-group                                                                                                                                    

real    111m50.678s
user    111m18.739s
sys     1m13.147s

>> CONFIG_CC_VERSION_TEXT="Debian clang version 16.0.6 (++20230610113307+7cbf1a259152-1~exp1~20230610233402.106)"
>>
>>
>> Björn
