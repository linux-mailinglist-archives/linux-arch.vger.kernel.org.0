Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1937783745
	for <lists+linux-arch@lfdr.de>; Tue, 22 Aug 2023 03:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjHVBRT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Aug 2023 21:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjHVBRS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Aug 2023 21:17:18 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1802184;
        Mon, 21 Aug 2023 18:17:16 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-68a4025b5e8so1350379b3a.3;
        Mon, 21 Aug 2023 18:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692667036; x=1693271836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvCdHBtjSnuFrbABVz90pmxppJPtgweSzJ+1K52oA8A=;
        b=j2Q7m9U7y9yiSOo1nBNYQc+vdbfKlu0KrZaTbV2cnPcsZk+O1v4ULZVirqtxG61Deu
         TN81mwJVnwGGcQ4fAmzSGgjMd4X9BkZphcqdb6/KETay7qq4PTT+YqZ3JU6DGYG6YBzx
         oYtrGkqItk0S298vt1eobaKlxhIbCLJ4J9BbcHluyFVN1Dz6bqYRic4jtLChhhxqvQic
         ZwTBEUbHuCOzNVN1xrPldvGJePV9EroYAXv/U7P6yQ+fl3l1L2gynjZgOKTb5VZu9YaS
         tr00BrmQjrNHuEGoMT4yy+ZZEF5zalPvSvqcjpDBALufs4T7fHoC44f18nT28KcO/ae5
         lM0A==
X-Gm-Message-State: AOJu0Yw2acWZqjGx8fBoMgUaJyfowu68ZpuCjGPqKqFYSq8axoKg4mC4
        N8ol23n9fzpgvxrXeU+nYr8=
X-Google-Smtp-Source: AGHT+IHMQh5HegE43CVlVbwBVI6hDP7ObjofAdRLJ03kKsEvoAIsU8gW2VhfpbtlaAbbRO20SNbPSw==
X-Received: by 2002:a05:6a20:a115:b0:13f:b028:789c with SMTP id q21-20020a056a20a11500b0013fb028789cmr7206284pzk.5.1692667036329;
        Mon, 21 Aug 2023 18:17:16 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b001bc39aa63ebsm7647738plb.121.2023.08.21.18.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 18:17:15 -0700 (PDT)
Date:   Tue, 22 Aug 2023 01:16:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, Tianyu Lan <tiala@microsoft.com>,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
Subject: Re: [PATCH v7 0/8] x86/hyperv: Add AMD sev-snp enlightened guest
 support on hyperv
Message-ID: <ZOQMiLEdPsD+pF8q@liuwe-devbox-debian-v2>
References: <20230818102919.1318039-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818102919.1318039-1-ltykernel@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 18, 2023 at 06:29:10AM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Tianyu Lan (8):
>   x86/hyperv: Add sev-snp enlightened guest static key
>   x86/hyperv: Set Virtual Trust Level in VMBus init message
>   x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP
>     enlightened guest
>   drivers: hv: Mark percpu hvcall input arg page unencrypted in SEV-SNP
>     enlightened guest
>   x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp
>     enlightened guest
>   clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp
>     enlightened guest
>   x86/hyperv: Add smp support for SEV-SNP guest
>   x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES

Applied to hyperv-next. Thanks.
