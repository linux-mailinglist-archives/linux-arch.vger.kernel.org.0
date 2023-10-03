Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A7C7B6B11
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbjJCOIU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Oct 2023 10:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjJCOIT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2023 10:08:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B8B0
        for <linux-arch@vger.kernel.org>; Tue,  3 Oct 2023 07:08:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-694f3444f94so733073b3a.2
        for <linux-arch@vger.kernel.org>; Tue, 03 Oct 2023 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696342096; x=1696946896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o9RQ2Fb9bLEnmrzYZSIfxNu7G1yFcSEUW3tQEd9IywA=;
        b=cGVyk2xwlUreSHZ1EKlYQrCktX9LtN6rFoaVbwUML2M1+SghLs7cmL64pd73vRTcZw
         5YB1u5OguDQAo/BWqx9Pyec/aSUmeHW4oOa7anxkN0P5zl9QGOEWRY0tdn/FUBKiG6ui
         WkH9w+XSYqdrMdo9j6FfGjv2/4mnVZvPEqOLHbAbZUpTnvTUOAfiyNoykAl2zkt68ufH
         CWtBlWD7FNXTyd/f+QPYoCzS9PlWqL7+5D6fFkURxKi/Bzi3T72GwZRxAKHDXJiVizDz
         kiFbp51/DRmWt1WiH/QsEzGNlSiEs4le8unHZMqXGrqoP4P+0aWq7rmhJPstfYBQftAF
         zjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696342096; x=1696946896;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9RQ2Fb9bLEnmrzYZSIfxNu7G1yFcSEUW3tQEd9IywA=;
        b=xR8sKm5wqoOLOhyhB9wZ/lc44V+aYTpI5k9UQ8yXk2qeiCkS3O6HAIoTbGyz1ikLrN
         BZyWuyGhaV5S93AFNn1RJpY9G8XuEHOTJpMhmkFFyK/4SWvGI7Jxd1ICkILBtDJSuNIs
         0ERKgVRdP9XSSWmmOyz6cg/HQAtur4MoR9xYJY2Tl12fepN7kFdjOhZann400Oei1qPb
         Wzt80XIgjGu4JeoECUORa2Q1KZbojGKlzFsqt+NmAy0Wd86QNmkHVGuoHYZi9hUTsLWU
         l9XU4nhiRWlfikxzYc1c8roSxgjF5k25JLOGb79DKBRqx2quY20rRKGJRGv/UOEq1J9p
         qPfg==
X-Gm-Message-State: AOJu0Yw0djaKHGD4vq0SRnyB0v2swuawjwzY4hQxD3dNsbKw5mPoMQql
        ziujfGHV8oiRdYVN7cOGM6HL8Q==
X-Google-Smtp-Source: AGHT+IFnebiHHdZDfxamsHmcSvnNx8iA5IlyEN1o219acCh5Cnqdc0JgdUD8yn/eqYycu6H4H4de0g==
X-Received: by 2002:a05:6a00:22cc:b0:68a:5cf8:dac5 with SMTP id f12-20020a056a0022cc00b0068a5cf8dac5mr16883440pfj.22.1696342095702;
        Tue, 03 Oct 2023 07:08:15 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c1:feaf:c9f1:61ab:649c:ad56? ([2804:1b3:a7c1:feaf:c9f1:61ab:649c:ad56])
        by smtp.gmail.com with ESMTPSA id h6-20020a62b406000000b006883561b421sm1390807pfn.162.2023.10.03.07.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 07:08:15 -0700 (PDT)
Message-ID: <057366c2-ee65-441d-b2ac-f40e1d94b44e@linaro.org>
Date:   Tue, 3 Oct 2023 11:08:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector,
 entries
Content-Language: en-US
To:     Peter Bergner <bergner@linux.ibm.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        GNU C Library <libc-alpha@sourceware.org>
References: <fd879f60-3f0b-48d1-bfa1-6d337768207e@linux.ibm.com>
 <97eb2099-23c2-4921-89ac-9523226ad221@linaro.org>
 <891957ad-453e-4c68-9c5a-7a979667543d@linux.ibm.com>
From:   Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <891957ad-453e-4c68-9c5a-7a979667543d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 02/10/23 18:19, Peter Bergner wrote:
> Hi Adhemerval, sorry for the delay in replying, I was a little under the
> weather last week.
> 
> 
> On 9/27/23 11:03 AM, Adhemerval Zanella Netto wrote:
>> On 26/09/23 19:02, Peter Bergner wrote:
>>> The powerpc toolchain keeps a copy of the HWCAP bit masks in our TCB for fast
>>> access by our __builtin_cpu_supports built-in function.  The TCB space for
>>> the HWCAP entries - which are created in pairs - is an ABI extension, so
>>> waiting to create the space for HWCAP3 and HWCAP4 until we need them is
>>> problematical, given distro unwillingness to apply ABI modifying patches
>>> to distro point releases.  Define AT_HWCAP3 and AT_HWCAP4 in the generic
>>> uapi header so they can be used in GLIBC to reserve space in the powerpc
>>> TCB for their future use.
>>
>> This is different than previously exported auxv, where each AT_* constant
>> would have a auxv entry. On glibc it would require changing _dl_parse_auxv
>> to iterate over the auxv_values to find AT_HWCAP3/AT_HWCAP4 (not ideal, 
>> but doable).
> 
> When you say different, do you mean because all AUXVs exported by the kernel
> *will* have an AT_HWCAP and AT_HWCAP2 entry and AT_HWCAP3/AT_HWCAP4 won't?
> I don't think that's a problem for either kernel or glibc side of things.
> I'm not even sure there is a guarantee that every AT_* value *must* be
> present in the exported AUXV.
> 
> The new AT_HWCAP3/AT_HWCAP4 defines are less than AT_MINSIGSTKSZ, so they
> don't affect the size of _dl_parse_auxv's auxv_values array size and the
> AT_HWCAP3 and AT_HWCAP4 entries in auxv_values[] are already initialized
> to zero today.  Additionally, the loop in _dl_parse_auxv already parses
> the entire AUXV, so there is no extra work for it to do, unless and until
> AT_HWCAP3 and AT_HWCAP4 start being exported by the kernel.  Really, the
> only extra work _dl_parse_auxv would need to do, is add two new stores:
> 
>   GLRO(dl_hwcap3) = auxv_values[AT_HWCAP3];
>   GLRO(dl_hwcap4) = auxv_values[AT_HWCAP4];
> 

Indeed you are right, I wrong assumed that the AT_HWCAP3/AT_HWCAP4 would
be higher than AT_MINSIGSTKSZ. 

> 
> 
>> Wouldn't be better to always export it on fs/binfmt_elf.c, along with all 
>> the machinery to setup it (ELF_HWCAP3, etc), along with proper documentation?
> 
> You mean modify the kernel now to export AT_HWCAP3 and AT_HWCAP4 as zero
> masks?  Is that really necessary since we don't need or have any features
> defined in them yet?  GLIBC's _dl_parse_auxv doesn't really need them to
> be exported either, since in the absence of the entries, it will just end
> up using zero masks for dl_hwcap3 and dl_hwcap4, so everything is copacetic
> even without any kernel changes.
> 
> As I mentioned, our real problem is the lead time for getting changes that
> affect the user ABI into a distro release, and ppc's copy/cache of the HWCAP
> masks is an ABI change.  If we wait to add this support until when we
> actually have a need for HWCAP3, then we won't have any support until
> the next major distro release.  However, if we can add this support now,
> which I don't think is an onerous change on glibc's part, then we can
> start using it immediately when Linux starts exporting them.

What it is not clear to me is what kind of ABI boundary you are trying to
preemptively add support here. The TCB ABI for __builtin_cpu_supports is
userland only, so if your intention is just to allow gcc to work on older
glibcs, it should be a matter to just reserve the space on tcbhead_t.  Once
kernel actually provides AT_HWCAP3/AT_HWCAP4, backporting should be
straightforward.

If your intention is to also add support on glibc, it makes more sense to
already reserve it.  For __builtin_cpu_supports it should work, although
for glibc itself some backporting would be required (to correctly showing
the bits with LD_SHOW_AUXV).


