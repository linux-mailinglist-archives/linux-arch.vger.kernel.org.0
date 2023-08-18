Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E57815D1
	for <lists+linux-arch@lfdr.de>; Sat, 19 Aug 2023 01:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbjHRX1A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 19:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242652AbjHRX04 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 19:26:56 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5DF4205;
        Fri, 18 Aug 2023 16:26:55 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6887918ed20so1325699b3a.2;
        Fri, 18 Aug 2023 16:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692401215; x=1693006015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsfLkqBQqdxaRuo7uj/qF8hlDrHgr+MRrYHL1O0X1hM=;
        b=IVk6QHRYefiIdxJEgwXwiOP6/eHles59jC7n1utQI2n9PQ5mSM7KvhMyEpZNU7e0YK
         QiHw77QhIcjwNXjFuAE/e5xRFZj1yPOExmKqvGN7myi/gPPkTiMOYKA4tc6Kfe1lUIrG
         h/PeVbVeCTshkvbIvjeUcLjdiTaFWfx0pLTYJU+rhEr/smD/hV2sBmMGOErKcyAjHnKa
         wt9AeOSVTEc6apqktbAKtMhhMPgzwCb8NgA3hCgWeXL/HhHf44VyZAKOxoBE24hvg6RE
         ktHkvQ9g6zHIby+VTIw6fKXjFCI9LQWdMXknbekqpsbqxc1+r3Zca9pet3O+0i7RDXbU
         6tXQ==
X-Gm-Message-State: AOJu0Yxkmr68Tb/mypoX8utq7bvEaFRtCzIvWDklEAiwn1b/QCvwZaj8
        ye/z+K1zK52xufikQAs0Mtp15+H7b7Q=
X-Google-Smtp-Source: AGHT+IGWjyNpgrOJ/NI64D+xsix0f/F8Hn5mj10s4nYBcvXzKG4Z2V+m193dmTs1JWaRTUKcpzhssQ==
X-Received: by 2002:a05:6a21:498e:b0:13f:5234:24ce with SMTP id ax14-20020a056a21498e00b0013f523424cemr692055pzc.28.1692401214839;
        Fri, 18 Aug 2023 16:26:54 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id m18-20020aa78a12000000b00688701c3941sm2022882pfa.111.2023.08.18.16.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 16:26:54 -0700 (PDT)
Date:   Fri, 18 Aug 2023 23:26:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v2 08/15] Drivers: hv: Introduce per-cpu event ring tail
Message-ID: <ZN/+LD2KMa8ANMiA@liuwe-devbox-debian-v2>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-9-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692309711-5573-9-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 17, 2023 at 03:01:44PM -0700, Nuno Das Neves wrote:
> Add a pointer hv_synic_eventring_tail to track the tail pointer for the
> SynIC event ring buffer for each SINT.
> 
> This will be used by the mshv driver, but must be tracked independently
> since the driver module could be removed and re-inserted.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
