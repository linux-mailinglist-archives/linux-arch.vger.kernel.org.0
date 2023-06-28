Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A077E7417C6
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 20:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjF1SFm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 14:05:42 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:58506 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjF1SFl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2023 14:05:41 -0400
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-262ff3a4659so2427888a91.0;
        Wed, 28 Jun 2023 11:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687975541; x=1690567541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6CGUiKfkA/rqCIECSBciDbZpKGwEtXOQFB5hLYmBzE=;
        b=elGdAmPqKGr5nx8WX8wbMJqsb3pgKIYNV3iqedm1eKT7E0+Xltj/dGhd1cES2y/XsL
         bOhBOq1w9x0l3JIVtDTtgOiEMX7G3PsNTDR8T+CrNLQtg6ObHOIKf5Sn5clCfLc02QIT
         hTMgboLDZTRWkQr+3hKjJfuMbBWlL0PP1WVxhVYe5Kxno8AlwU4AQX/z9yR9tONZ2Ilz
         mxxeOXpacaBecLRAgE+j6d3YTQesd652QZ91pt+dke7OQ/TjwGdwrgloXxdq73cGL4sg
         hQMFP3F3SCxOEZxVf8SHwnaNvB9fYoLii9yi6dHad0JDsvs/sjY/uN16Cf5hjPVgg1k+
         eXrg==
X-Gm-Message-State: AC+VfDw7EvZQ1NPVS5q5+6vW/3WEGz92wljqVtcixVXfmxMNLA+NKCcr
        97ia1tQQRF5UDsokNHm0RWw=
X-Google-Smtp-Source: ACHHUZ7FlAjGD9Xh6goc3LuzXD+WCH3hg+8oQQ7uIyDpxUBa6X9RTW50aPEtWkdCGQMLAyymK7Uezg==
X-Received: by 2002:a17:90a:df04:b0:262:fb5d:147d with SMTP id gp4-20020a17090adf0400b00262fb5d147dmr8277691pjb.16.1687975540932;
        Wed, 28 Jun 2023 11:05:40 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 91-20020a17090a0fe400b00259b53dccddsm8690914pjz.34.2023.06.28.11.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 11:05:40 -0700 (PDT)
Date:   Wed, 28 Jun 2023 18:05:38 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        wei.liu@kernel.org, x86@kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v9 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Message-ID: <ZJx2cm1HaMEcNIYy@liuwe-devbox-debian-v2>
References: <20230621191317.4129-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621191317.4129-1-decui@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 21, 2023 at 12:13:15PM -0700, Dexuan Cui wrote:
> The two patches are based on today's tip.git's master branch.
> 
> Note: the two patches don't apply to the current x86/tdx branch, which
> doesn't have commit 75d090fd167a ("x86/tdx: Add unaccepted memory support").
> 
> As Dave suggested, I moved some local variables of tdx_map_gpa() to
> inside the loop. I added Sathyanarayanan's Reviewed-by.
> 
> Please review.
> 
> FWIW, the old versons are here:
> v8: https://lwn.net/ml/linux-kernel/20230620154830.25442-1-decui@microsoft.com/
> v7: https://lwn.net/ml/linux-kernel/20230616044701.15888-1-decui%40microsoft.com/
> v6: https://lwn.net/ml/linux-kernel/20230504225351.10765-1-decui@microsoft.com/
> 
> Dexuan Cui (2):
>   x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
>   x86/tdx: Support vmalloc() for tdx_enc_status_changed()
> 
>  arch/x86/coco/tdx/tdx.c           | 87 ++++++++++++++++++++++++++-----
>  arch/x86/include/asm/shared/tdx.h |  2 +
>  2 files changed, 77 insertions(+), 12 deletions(-)

Dexuan, do you expect these to go through the Hyper-V tree?

Thanks,
Wei.

> 
> -- 
> 2.25.1
> 
