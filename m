Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E593A6F6F6F
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 17:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjEDPzU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 11:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEDPzS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 11:55:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B644EE1;
        Thu,  4 May 2023 08:55:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115e652eeso13521783b3a.0;
        Thu, 04 May 2023 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683215717; x=1685807717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SABdJwATGpnYNpw+VYDsD7QzVmuuG5ZhWoaCFqVkYME=;
        b=KBZWZ39Enx4Z9uQK/wh5efZaK9Et6sjBSgM3MPSmZ9O8eG7X7zXR75SpnT6YBUNYub
         aPoB9KIYp3GhHwWFdKTWbMxV3OCclj5+Plt3JcNubqIZGZ2VGBv+5y+hWlHLC0Kc53KC
         qdv6RoqbJRcxSC2BHivAvTovz1cb4CMxOiNKgbfB9gCjOX8YO0hKUjylvHlceUu5PWfF
         IlbhVGtSJWCAbG2MWOQlEbbE/OESMD3Ad/bc/lIgNPEB9wrJ4Qx3nzmtBmHFLAljZBd0
         YAegg9RX80/wQp9HTZzR0OK/seXiH0Ss7nlDg/ViSiWQAJaKfWsx835aiZyYRTzRrBoM
         PemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683215717; x=1685807717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SABdJwATGpnYNpw+VYDsD7QzVmuuG5ZhWoaCFqVkYME=;
        b=Q6otaoMwjEofM5BO+uj0R7vepbe3FimDjDc3652K0rmAtrxKooQ0E5PiE6US433Anc
         bDaXPjJiipcdP/dwy+X5WNrIRNI1po55ZOiO/nyXk7EtYXc+Qi7Ia2a6p2/lmXrOD/7e
         cbT9T/g+kTCLY/IYjWWWIdS94zNgjuYZ7BSdAkFn4+RcfhP++JoLcITONFdKEIy+XpaJ
         djr046vY4cdR8nYJTDRis1sXPFsxtrdXS5tRvypKUBSlKP5Kocc07aacTHKvN6L4BU8d
         neVBlw4F53kbTE68GBAGHKLSP1oNiEbT4tqbJmtxKFZ1NfaOLY6jVP6Ykh1Nl1nQ0qr0
         +9xQ==
X-Gm-Message-State: AC+VfDwtS82Bf3pSlDbz4/n+vBOxRvTqzkq12hdQM14e/IbidJQrS2GZ
        fVo2g1kACCQg9V8ueQ8SKXs=
X-Google-Smtp-Source: ACHHUZ6zKY3ZNedn9zzEItNXl28AhWsGrlUm54WiaShNHwsmKfdLnbKDsw8jV9i185h3rjlV/1mlfw==
X-Received: by 2002:a05:6a00:1886:b0:636:e0fb:8c45 with SMTP id x6-20020a056a00188600b00636e0fb8c45mr3183635pfh.16.1683215717427;
        Thu, 04 May 2023 08:55:17 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5::e29? ([2404:f801:9000:18:6fec::e29])
        by smtp.gmail.com with ESMTPSA id 188-20020a6219c5000000b00640e01dfba0sm19340002pfz.175.2023.05.04.08.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:55:17 -0700 (PDT)
Message-ID: <f01b9a94-29c0-c5e4-9b99-0532807bc8ce@gmail.com>
Date:   Thu, 4 May 2023 08:55:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [EXTERNAL] [RFC PATCH V5 09/15] x86/hyperv: Add smp support for
 sev-snp guest
Content-Language: en-US
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
Cc:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230501085726.544209-1-ltykernel@gmail.com>
 <20230501085726.544209-10-ltykernel@gmail.com>
 <PUZP153MB07493DA8F1085DE38DB1AFB8BE6E9@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <PUZP153MB07493DA8F1085DE38DB1AFB8BE6E9@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/1/2023 3:20 AM, Saurabh Singh Sengar wrote:
>> +struct hv_start_virtual_processor_input {
>> +	u64 partitionid;
>> +	u32 vpindex;
>> +	u8 targetvtl;
>> +	u8 padding[3];
>> +	u8 context[0xe0];
>> +} __packed;
> "struct hv_enable_vp_vtl " is defined in arch/x86/include/asm/hyperv-tlfs.h. Please check if that can be reused in place of both the above structs.
> - Saurabh
> 

Yes, these are redundant and will reuse new struct. Thanks.
