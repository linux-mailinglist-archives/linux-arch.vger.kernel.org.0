Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A107B7DB1
	for <lists+linux-arch@lfdr.de>; Wed,  4 Oct 2023 13:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjJDLCh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Oct 2023 07:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjJDLCg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2023 07:02:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ACDD3
        for <linux-arch@vger.kernel.org>; Wed,  4 Oct 2023 04:02:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5ff5f858dso14984685ad.2
        for <linux-arch@vger.kernel.org>; Wed, 04 Oct 2023 04:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696417353; x=1697022153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/3oXbSz4Vr/TO4F6Fo1F+L1aN+UvHmKyPB5CbaVXPdE=;
        b=OHQ9kO0hKj9j9v321/N55Trqeb13g5Adq56G+S0mOBYx0yWs8U+w7UuVFUgnWCo6v+
         QSsV0lD1uhd2mRtEVaRdYMIXIP5wdEicNdDIp1RcxK4vAOq0+cQ4cRvyS2OlUsXg6e5N
         jTGDJb50OEHd4soOWa+EIP8dpgw7nlExxHlvSbMuLSsVlfbI2fIMkivAtlhdA7VeTwcT
         Rw7TZ4C7Kr1yGW8IOiAs56uH+7vyegPjfkMTkPT1IfnrAOnr/xLCKQoCalv/hsIZNS5w
         MWDIkUv74IQ9M1zJ3UrYTMXIb2ViYpFfmIkte6L1KuLAplUHcK+2W16MWZBdPGLlZPCw
         MOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696417353; x=1697022153;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3oXbSz4Vr/TO4F6Fo1F+L1aN+UvHmKyPB5CbaVXPdE=;
        b=WD8Iua5d62jeHKCUEuWNNVDn4uWgCJ54iN4AGKxIdrQwW7raHCaU2pLbEmPdmKEcdR
         hRDMJNGvSsSDqKIHtshFII/EKQZvRHoEaY7i70ulgTRefpGSwqnJ6kM2RcHgg7/QuL9q
         PgUiEzxyLjb65itW9p6boXQXi/mleYQP6ExkWMiMXBYPduQW9sg41OdCJiicVrbSQkUZ
         DLiLb5n/JNsQfJgSCcy7w3JED9IlzrdBYTSIMySf34PDfuTKMJb1ilJOMhcEU/MOdWPw
         5tsOqLz3NIz30MSZBMo3OsOGH0iwJ8IOAds0HglhTsKKaf2f/j60JerHf7RoohBSbib1
         Mo9g==
X-Gm-Message-State: AOJu0YwRFkTY8y4wpcv10nNnIUlM+Ls+gqV/4fS4v61aYzIoZ68uZyNE
        EhSR8uQpdciZnETBsRn6ldloEQ==
X-Google-Smtp-Source: AGHT+IHE2lbIz5Y66kYbALC9n6ii47EHeeCGPmVVWRQJyGC4GKJ6zn27JE3pya096RVjF3OIVgPZlQ==
X-Received: by 2002:a17:902:c94f:b0:1c3:8464:cabd with SMTP id i15-20020a170902c94f00b001c38464cabdmr2190766pla.12.1696417352641;
        Wed, 04 Oct 2023 04:02:32 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c1:feaf:b959:23ff:3a18:c5dc? ([2804:1b3:a7c1:feaf:b959:23ff:3a18:c5dc])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e81000b001bd99fd1114sm3370394plg.288.2023.10.04.04.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 04:02:31 -0700 (PDT)
Message-ID: <bea513ab-9ee2-4808-a490-c7dee5de26a6@linaro.org>
Date:   Wed, 4 Oct 2023 08:02:28 -0300
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
 <057366c2-ee65-441d-b2ac-f40e1d94b44e@linaro.org>
 <b4864730-1b12-4dd8-b6e9-85d78dad5e34@linux.ibm.com>
From:   Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <b4864730-1b12-4dd8-b6e9-85d78dad5e34@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 03/10/23 19:12, Peter Bergner wrote:
> On 10/3/23 9:08 AM, Adhemerval Zanella Netto wrote:
>> What it is not clear to me is what kind of ABI boundary you are trying to
>> preemptively add support here. The TCB ABI for __builtin_cpu_supports is
>> userland only, so if your intention is just to allow gcc to work on older
>> glibcs, it should be a matter to just reserve the space on tcbhead_t.
> 
> Yes, extending tcbhead_t to contain the slots for hwcap3 and hwcap4 are the
> ABI extensions we are interested in, and not something that can be backported
> into a distro point release.  Yes, we don't strictly need the AT_HWCAP3 and
> AT_HWCAP4 kernel defines to reserve (and clear) that space in glibc, but....
> 
> 
> 
>> If your intention is to also add support on glibc, it makes more sense to
>> already reserve it.  For __builtin_cpu_supports it should work, although
>> for glibc itself some backporting would be required (to correctly showing
>> the bits with LD_SHOW_AUXV).
> 
> Our intention is to also add the glibc support too once we have the
> AT_HWCAP3 and AT_HWCAP4 kernel macros defined.  1) Once the defines are
> there, adding the support should be pretty straight forward, so why wait?
> And 2) part of the glibc and compiler support introduces a new symbol
> that is exported by glibc and referenced by the compilers to ensure the
> compilers *never* access the hwcap* fields in the TCB unless the glibc
> supports them.  See the symbol __parse_hwcap_and_convert_at_platform used
> for HWCAP/HWCAP2.  We'll need a similar one for HWCAP3/HWCAP4 and I'm
> doubtful whether the distros will allow the backport of a patch that
> introduces a new exported symbol from glibc in a distro point release.

Alright, I makes more sense it now.  And indeed backporting a __parse_hwcap
for HWCAP3/HWCAP4 will be frown upon.
