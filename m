Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CACD68D9A5
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 14:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjBGNuB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Feb 2023 08:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjBGNuA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2023 08:50:00 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFF56193;
        Tue,  7 Feb 2023 05:50:00 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so14999622pjb.1;
        Tue, 07 Feb 2023 05:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0r46ppL6ozLVP3QrORxnEYkrjxwfEwInowE8qS44Mo=;
        b=g8ZHyDoYN04FkE2feK0I4E7S2f42QjvQyHvrqsplBAorVioUuL/Wncowih2hU++e+n
         71MwnpwSW4FmhAcXC6B3QjfUqkm5Fo2SqRv0QeafOmCUu2iaA/gPgxuB6nSehs2R5gfl
         DhJi12Y2VPzNpyyOc7vG71jUuLSOGFg+9qh8nDEU0R1wOCDP1Q9RvMId1YsKVeltNF/W
         X0b12MDvj9UBpauirRSmFwwcgTvVR/C5zJaqPdTngrAI7dJEXvNfDD7jDnmx0E7Spf9f
         I+8/aqKadoQJ7WXnl1+kzCKOL9FQgU36uko9n4U5oq7+3/PodpV8O4odqYNlAK3xEC/L
         JlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M0r46ppL6ozLVP3QrORxnEYkrjxwfEwInowE8qS44Mo=;
        b=Z5yn1SlaHdxfYsaSY9Yh7Hx+gjRTMZoBciINWKh0R51ly4ul6x3H5Sm7UhbalHag5e
         r17yJe3sX53n26EfArNTJwqWXKZruyLJT3h6PRs2ufKSmuuRsC/k98FRUzzjdJ4XF+p3
         KavFQflQkH0in/5cmLz1uXVdTI13D6wikqc3Yk1SD89Nr/Y/ws4se9DTRMq99XOzbNzN
         IhorsacuwCpHoKm1CwDjLN2DX1L1f/XcbH4uIVyTj7TJbSa5KwrN5onvKX8PfbYt2TmC
         JoGDr7PixIzjin2vbmIufkBefRHIlWMzM7NSzCTsAR7yeR6ll36P1ZUy3utkde1yp7n8
         SOfA==
X-Gm-Message-State: AO0yUKUtalwQ+v7spNFwv6iJNsBA4MS9HYuAWj7hmO61IE01B855yU4G
        dpgOFV3I0ErDzwvHaigO6jg=
X-Google-Smtp-Source: AK7set9XJjLcHW4lgrQJY51r8GSMNbC83fh8jRN6zJKCAwc4w4SJJFkjxiuyZdAiWcEYYy1PAyX1Nw==
X-Received: by 2002:a05:6a21:3298:b0:c0:c429:cbbd with SMTP id yt24-20020a056a21329800b000c0c429cbbdmr4371483pzb.6.1675777799669;
        Tue, 07 Feb 2023 05:49:59 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id x3-20020aa79183000000b005769b23260fsm9529424pfa.18.2023.02.07.05.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 05:49:59 -0800 (PST)
Message-ID: <45e6a0b5-77fa-6ca2-f3a3-9cf61fdb56a6@gmail.com>
Date:   Tue, 7 Feb 2023 21:49:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V3 10/16] x86/hyperv: Add smp support for sev-snp
 guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, seanjc@google.com,
        pbonzini@redhat.com, jgross@suse.com, tiala@microsoft.com,
        kirill@shutemov.name, jiangshan.ljs@antgroup.com,
        peterz@infradead.org, ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-11-ltykernel@gmail.com>
 <62ffd8b2-3d88-499e-ba13-1da26f664c6f@amd.com>
 <ce9b4a79-b877-211d-aee8-bbc02e6805b5@gmail.com> <Y+Fe390kWFnAh6gC@zn.tnic>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <Y+Fe390kWFnAh6gC@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/7/2023 4:11 AM, Borislav Petkov wrote:
> On Fri, Feb 03, 2023 at 03:00:44PM +0800, Tianyu Lan wrote:
>>> For the bits definition, use:
>>>
>>>               u64 sev_feature_snp            : 1,
>>>                   sev_feature_vtom            : 1,
>>>                   sev_feature_reflectvc        : 1,
>>>                   ...
>>>
>>
>> Good suggestion. Thanks.
> 
> Actually, I'd prefer if you used a named union and drop all this
> "sev_feature_" prefixes everywhere:
> 
>          union {
>                  struct {
>                          u64 snp                     : 1;
>                          u64 vtom                    : 1;
>                          u64 reflectvc               : 1;
>                          u64 restrict_injection      : 1;
>                          u64 alternate_injection     : 1;
>                          u64 full_debug              : 1;
>                          u64 reserved1               : 1;
>                          u64 snpbtb_isolation        : 1;
>                          u64 resrved2                : 56;
>                  };
>                  u64 val;
>          } sev_features;
> 
> 
> 
> so that you can do in code:
> 
> 	struct sev_es_save_area *sev;
> 
> 	...
> 
> 	sev->sev_features.snp = ...
> 
> and so on.

Hi Boris:
	Thanks a lot for your suggestion. Will update.
