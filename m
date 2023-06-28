Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE3674177B
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 19:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjF1RwF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 13:52:05 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:59881 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjF1Rv6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2023 13:51:58 -0400
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-543c692db30so4834567a12.3;
        Wed, 28 Jun 2023 10:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687974718; x=1690566718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4gcMA0oAXbXxZ6AhiBL84jasGitldsUSZgsSv4UPKo=;
        b=lrj52n+oBR7QDrdKt0ShmUe2c7ZQ7XZaCmpm9sQcpyqaEMxx7/887hVOtMXomip7z8
         EWXp69x1bYpydGy9rZ+DyHsUwGB83JwU+0VU2zR/+N4s/PFyb+Vif6gYu0JA3/5pjdjo
         Tfqfh7hirVpLIF3zd28r7G2k7oWph1wPFCbSveYcjWdp+A3YTie1IfYCJJy6xrd//TUx
         xpaWkRtivjRCdiK7NvmNjruilnCgc2Uc7/diPknbcdNInxFkOkCqhb1G+w9ggtDFw437
         5ONLwj++1FOCr9t5UPgTca67xxYe1OwWl2k84Q316Wdrc3aHOwSZFu9OWkqcZdW3OF13
         dzVA==
X-Gm-Message-State: AC+VfDy2aLC2M6G7r8+kT/INIYp8JeziniOh2mTvKRh4p3Ax6Nc9RFhj
        5KY2e5vbunHBabYZGW1co78=
X-Google-Smtp-Source: ACHHUZ6qiJMmUvs92SwZ633rCVbaKSKSga815p5pMFTq3uIitHFEy2OBiILhM/oZ0gd1Vk8cJHgW+w==
X-Received: by 2002:a17:90a:7522:b0:25d:e321:c4e8 with SMTP id q31-20020a17090a752200b0025de321c4e8mr34433756pjk.41.1687974718159;
        Wed, 28 Jun 2023 10:51:58 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id oj3-20020a17090b4d8300b0024e4f169931sm9905468pjb.2.2023.06.28.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 10:51:57 -0700 (PDT)
Date:   Wed, 28 Jun 2023 17:51:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Kameron Carr <kameroncarr@linux.microsoft.com>
Cc:     arnd@arndb.de, decui@microsoft.com, haiyangz@microsoft.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        wei.liu@kernel.org
Subject: Re: [PATCH v2] Drivers: hv: Change hv_free_hyperv_page() to take
 void * argument
Message-ID: <ZJxzPBE5mDVBUKCE@liuwe-devbox-debian-v2>
References: <1687558189-19734-1-git-send-email-kameroncarr@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687558189-19734-1-git-send-email-kameroncarr@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 23, 2023 at 03:09:49PM -0700, Kameron Carr wrote:
> Currently hv_free_hyperv_page() takes an unsigned long argument, which
> is inconsistent with the void * return value from the corresponding
> hv_alloc_hyperv_page() function and variants. This creates unnecessary
> extra casting.
> 
> Change the hv_free_hyperv_page() argument type to void *.
> Also remove redundant casts from invocations of
> hv_alloc_hyperv_page() and variants.
> 
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>

Applied to hyperv-fixes. Thanks!
