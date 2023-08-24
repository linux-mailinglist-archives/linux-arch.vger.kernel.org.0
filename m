Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6165178721B
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 16:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjHXOqE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 10:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241842AbjHXOpw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 10:45:52 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6301BE7;
        Thu, 24 Aug 2023 07:45:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68bee12e842so662014b3a.3;
        Thu, 24 Aug 2023 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692888345; x=1693493145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V34KTjUax4ElVUXtcgSRy6iibO4cjpLJVJbRtQW8DEA=;
        b=Ovo31Uv6a2OSnXKhonXx+LyqgidfKlMY93wLa1zJr0sWilTyIPbm2byjwlpyP3j1Mc
         SxRB1rTeUmTQymg8x1XF893UMcJmi5LMzcbwL6JyzaigSUru5aHSA63ahHkWBAUxl3DP
         Z4rRrdFvfD0BTIpxAL6CEMobBqVud+YCoaNwVxvsMlbVY+PqjghNSHPa/dTS2Gpqqafx
         ojRPR0Bkq9swVXO8a/4vsf+/NaMtypagWXrXQ/KdTARIxUu/6T2wdw6DuCVs2Zj7Dtv/
         6B4GjPmtLVyiKJytC92YjOQkJTiLz+4w+fTlQdSKoCz9+cryN1Kt3zshAmTEq3BcpqZB
         uMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692888345; x=1693493145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V34KTjUax4ElVUXtcgSRy6iibO4cjpLJVJbRtQW8DEA=;
        b=hCKJPfjr0cHl8l+aczlbyb56criT9XNbDjKYdS2smlEVgDYg4Vu0t6zDMYxrVdcp7o
         kjZWURZEKS1QMP0uVOEjW7jgQycp9b5KlSfQpyphrAgacjmXoNpcEr+YUyA8CRq5ivWI
         7PeRiFJPh5OENVzw2zfcyAX1ri9ydwNIJSUk0QLWph9UsJvVfl5xLwEeJTc9kq78iSAt
         d6h/yMfrCyctIm+V9+1sMFjA5msfY95C/Zu8nQ/ayg/rRFs6g8jiZq95UVuUn3W4mh91
         JcItruqpbwMGhe3OmjswvOiL5VTNYUHbjWb03bhO6rd9uLgLrMsHL4yLEV2jyXG/MbnE
         /pkQ==
X-Gm-Message-State: AOJu0YyLyD5xLcxOcKEyMRfHAEtfqt+sDHhubtdOxd43XxOJezPPaE49
        X9a0PfwAhsltHJSTJspn8ao=
X-Google-Smtp-Source: AGHT+IGiwd3hJaunLjoNoluRg6yzgJu4qOKHRcicoNdJPlBFrEjmxOMJujom+4ieDcaIYVEZcqOOug==
X-Received: by 2002:a05:6a00:1495:b0:68a:5d25:7fea with SMTP id v21-20020a056a00149500b0068a5d257feamr10633069pfu.6.1692888345220;
        Thu, 24 Aug 2023 07:45:45 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id e20-20020aa78c54000000b0068a46cd4120sm7404930pfd.199.2023.08.24.07.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:45:44 -0700 (PDT)
Message-ID: <ff179294-b556-ab16-a884-10acaef456f4@gmail.com>
Date:   Thu, 24 Aug 2023 22:45:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 09/10] x86/hyperv: Remove hv_isolation_type_en_snp
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
References: <20230824080712.30327-1-decui@microsoft.com>
 <20230824080712.30327-10-decui@microsoft.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230824080712.30327-10-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/24/2023 4:07 PM, Dexuan Cui wrote:
> In ms_hyperv_init_platform(), do not distinguish between a SNP VM with
> the paravisor and a SNP VM without the paravisor.
> 
> Replace hv_isolation_type_en_snp() with
> !ms_hyperv.paravisor_present && hv_isolation_type_snp().
> 
> The hv_isolation_type_en_snp() in drivers/hv/hv.c and
> drivers/hv/hv_common.c can be changed to hv_isolation_type_snp() since
> we know !ms_hyperv.paravisor_present is true there.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>
