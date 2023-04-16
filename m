Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABD06E35A8
	for <lists+linux-arch@lfdr.de>; Sun, 16 Apr 2023 09:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjDPHWQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Apr 2023 03:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjDPHWO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Apr 2023 03:22:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8733599;
        Sun, 16 Apr 2023 00:21:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id la3so22423455plb.11;
        Sun, 16 Apr 2023 00:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681629703; x=1684221703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82oJRPirvXuTskNseCQRgDi71ADu1/69G4a2xUOXGPg=;
        b=DPwBcVtuhJKFiVL0G2fvbFc9rS+ARpBawp6rAG3ItDNml9fjqQYdphQOqghmNmeN+6
         xH2tpIcvOrE9RLZH503TvGn+jkrejxuqgkYKj73EhMj05X1PORC7AU76zSEKu4mUXtcD
         W00tMIEYLriPhTNtrL/L1vmhybgomchVpmd4SulXEm/EfhKh75IuxK7yWkXIsBSjtzMM
         XmlUQC2BllMdz7WWLeIjE9X3Fq8IGGQFdBbE/G9R4RluU8Nkxb2RhDhQJGTQDKqvEVxJ
         HyHV4IhGNo9jDD46IqoQ03aNI/XiIKc/0mEnD7VE1+asony4O6IVOTQlBTWdpksYS2on
         yqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629703; x=1684221703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=82oJRPirvXuTskNseCQRgDi71ADu1/69G4a2xUOXGPg=;
        b=Ku+HPAOKbKg5Sad0VqugX+38eYLL83C8zMLnuvbVvKLSbbx/Wtxa9LcfnA20vvWGxc
         AuGPx/bi0zEpi4c927Lmaiw9VI/yqJsBOQPpjxQlMnzcvl5uxpdqNa3S88/+fxpzMmEU
         w/fU6gphSKOXBEfEOATStP9noQJTtjd0gwmryFHdvgi7ganIIZdXEgUTY4xsS9ztmJrV
         ULvWVJC6nPWb5TfYV3nN4jjqvNEHxNgFbqHmoArzLspQJ7OBMizM/HaxGT14xGulBQpC
         D9oIU97BdCpjCYY3eQctKZobRF4vYhFBw2VAb0EwqTPJsbJ8pXolEB0+cADQlTMDO82n
         bHgQ==
X-Gm-Message-State: AAQBX9edowF4+A5IdT+x8NrMtU+E2pOgHhyTTwCaDCYhN9SDByV01yXV
        C1fRD5lxZwCOzpgbwQquqT0=
X-Google-Smtp-Source: AKy350apEqZB2QuXDkO1vYGt4ZGWDy4pJbAx3Q5kYdzJ7RiELGnKGVGDR4jbv+UCHJI2ncYEzYOZHA==
X-Received: by 2002:a17:90a:4403:b0:246:ac0b:9d40 with SMTP id s3-20020a17090a440300b00246ac0b9d40mr11178577pjg.15.1681629702710;
        Sun, 16 Apr 2023 00:21:42 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id q35-20020a17090a17a600b002409bf5ddfasm4888753pja.35.2023.04.16.00.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 00:21:42 -0700 (PDT)
Message-ID: <32dec1c9-d38b-1612-ba53-17c495c120d3@gmail.com>
Date:   Sun, 16 Apr 2023 15:21:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH V4 14/17] x86/hyperv/sev: Add AMD sev-snp enlightened
 guest support on hyperv
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-15-ltykernel@gmail.com>
 <f840f7bc-887d-d69f-54fd-68acfdb9a076@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <f840f7bc-887d-d69f-54fd-68acfdb9a076@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/5/2023 1:43 PM, Gupta, Pankaj wrote:
>> +
>> +        if (!pending_events.vector)
>> +            return;
> 
> This prevents do_exc_hv() executing from #hv handler as 
> "hv_handling_events" never resets?
> 

Nice catch! Will fix in the next version.
