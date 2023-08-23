Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA62F78547C
	for <lists+linux-arch@lfdr.de>; Wed, 23 Aug 2023 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjHWJq3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Aug 2023 05:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbjHWJnB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2023 05:43:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69290E5F;
        Wed, 23 Aug 2023 02:13:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a1af910e0so2717091b3a.2;
        Wed, 23 Aug 2023 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692782011; x=1693386811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOms2f4/L91imgkkuFrGq9Z9J53A0PDpV5lJYbBBlWc=;
        b=Ud8nSYAy78ovklEn6i4is9lKdU1r1EmdnbAuRRy+PcZ6iRnAMpCzhvvzjeUOyZZnf+
         cueS1TxXZ3Lu4i2QS+VizxbGFHZCEhndx7WHnCZvSTQ69rzKvuCZIuzbvNNHC8VXAuO6
         9OVCUO8xCOHFXPmlCDe8yNwJm3+Vg4n4beieSJqzCnCeIjFOPdpafyvFxAU9rHYgr/8u
         ENWETQVezZV2Exr8gm3GO06Pc2huU2R1ue2aRq/Cd5DZDMNSBrihOZxOz5kAvNg68K7l
         xR3t+Tr6ZGU816b8W4BLADhBKHd1eGLOAQ3nf9AkjM1hvBrf1MLjRhyO/GnPi+lzN8UZ
         UBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692782011; x=1693386811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lOms2f4/L91imgkkuFrGq9Z9J53A0PDpV5lJYbBBlWc=;
        b=e4HhcXGkxeFZt6osNDdsQLMerWWurZIMlRSclQIpXlYYZuaVP2odMgoEtg1LpCmr6k
         6/P3Ubt2sY5rcf4MqS/2jhLtrH2dMYINbTZpnFkg9pHcMwgTdv/ikx7kpgaz/FimXkw1
         jtux8qdfcobbY0Ot9PUMpAp1Bu1+ATrtZy/Y1Vf+C4wAl95MwokbwEsW0LBjCH7f61Xz
         kjYQwHcdy8bKwwzROP4wiGiyXr4iGvCzjlPGJpHFFnrcGPzrOLpKpqq4wImOPziYnBNA
         jV7SwKZZcxaHwEPvgHLTUP4+vPgiu5KmTLay0PKVpwsQEVxkFlLofrDQxCxs4MD4X2vz
         UbVA==
X-Gm-Message-State: AOJu0YyzByZ7TiryTFojfWGkiVb/s2WkDzCmC91NVeX6tB2u+Q8djJP7
        ngbBsFrVf+8m/tLtfTY5G5Y=
X-Google-Smtp-Source: AGHT+IGr1srhgonkVCsAJggt0XMtR/IpUTB/MF4nTQAoSUEtIY2WKQ+tvCqg2u3ftQew5hUPbSSTqA==
X-Received: by 2002:a05:6a00:c89:b0:682:4801:93d3 with SMTP id a9-20020a056a000c8900b00682480193d3mr10166805pfv.31.1692782011164;
        Wed, 23 Aug 2023 02:13:31 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id a19-20020a62e213000000b0068844ee18dfsm567954pfi.83.2023.08.23.02.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 02:13:30 -0700 (PDT)
Message-ID: <064c4135-2d03-a34b-dcfd-f2203bac2464@gmail.com>
Date:   Wed, 23 Aug 2023 17:13:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5/9] Drivers: hv: vmbus: Support >64 VPs for a fully
 enlightened TDX/SNP VM
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com
References: <20230811221851.10244-1-decui@microsoft.com>
 <20230811221851.10244-6-decui@microsoft.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230811221851.10244-6-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/12/2023 6:18 AM, Dexuan Cui wrote:
> Don't set *this_cpu_ptr(hyperv_pcpu_input_arg) before the function
> set_memory_decrypted() returns, otherwise we run into this ticky issue:
> 
> For a fully enlightened TDX/SNP VM, in hv_common_cpu_init(),
> *this_cpu_ptr(hyperv_pcpu_input_arg) is an encrypted page before
> the set_memory_decrypted() returns.
> 
> When such a VM has more than 64 VPs, if the hyperv_pcpu_input_arg is not
> NULL, hv_common_cpu_init() -> set_memory_decrypted() -> ... ->
> cpa_flush() -> on_each_cpu() -> ... -> hv_send_ipi_mask() -> ... ->
> __send_ipi_mask_ex() tries to call hv_do_fast_hypercall16() with the
> hyperv_pcpu_input_arg as the hypercall input page, which must be a
> decrypted page in such a VM, but the page is still encrypted at this
> point, and a fatal fault is triggered.
> 
> Fix the issue by setting *this_cpu_ptr(hyperv_pcpu_input_arg) after
> set_memory_decrypted(): if the hyperv_pcpu_input_arg is NULL,
> __send_ipi_mask_ex() returns HV_STATUS_INVALID_PARAMETER immediately,
> and hv_send_ipi_mask() falls back to orig_apic.send_IPI_mask(),
> which can use x2apic_send_IPI_all(), which may be slightly slower than
> the hypercall but still works correctly in such a VM.
>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>
