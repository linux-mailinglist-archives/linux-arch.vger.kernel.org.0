Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBA37815C4
	for <lists+linux-arch@lfdr.de>; Sat, 19 Aug 2023 01:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbjHRXWd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 19:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242620AbjHRXWb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 19:22:31 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB72D4206;
        Fri, 18 Aug 2023 16:22:30 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1bcad794ad4so11692585ad.3;
        Fri, 18 Aug 2023 16:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692400950; x=1693005750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qYtGq59zin9uHa3ggwJoqxjied2x9Zxiu9P/symY5c=;
        b=DOtlVdVGFLk2dJkSyE3HfgdaNxIQtdDjWYb53cX6eqxHADZKkjAqtWsm6nfrFzh6i7
         dFoLmF1J80Hgr4zGDAzdWeSrNcaLZTKW/3pjZ+8TYKvdvmoB5RuvTfeRVIYuufKbdTLf
         W8XFbYUru1jnGJAIzl9nH8/CZ3VhnKSd9X39OaA5W0Ivh+TQB5HMfsbbW1w5JCBF+h/F
         bP5p5aq/pBjZSf3DPl8jmO25v6BpjZfB23dKM2H/mAFKIgWm5RaD899zZJeeGW5rcWWz
         2AofFbP7cCbWagwCPoeyJ06sGV+AGkzIcXhx+Y5JJF3aX+xVr/ID41puMbC5lyKJFWxG
         lVlw==
X-Gm-Message-State: AOJu0YxINy6s86xvuUSigh3hx4QWasDX4147DlHvIWfqo9JcLLfxkG88
        dKw1JHv1kIJudOjeFF4FpOY=
X-Google-Smtp-Source: AGHT+IEKSrt1dc+AYw5tbCHnGumAQmr7S5KGpU/LDuisCST2TbkwtFJexNytNi5qJnGEvHVTR2tWqg==
X-Received: by 2002:a17:902:d511:b0:1bc:5e50:9345 with SMTP id b17-20020a170902d51100b001bc5e509345mr671945plg.50.1692400950200;
        Fri, 18 Aug 2023 16:22:30 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902968400b001bbb7af4963sm2292110plp.68.2023.08.18.16.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 16:22:29 -0700 (PDT)
Date:   Fri, 18 Aug 2023 23:22:12 +0000
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
Subject: Re: [PATCH v2 05/15] hyperv: Move hv_connection_id to hyperv-tlfs
Message-ID: <ZN/9JDlUAFFdEVGU@liuwe-devbox-debian-v2>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-6-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692309711-5573-6-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 17, 2023 at 03:01:41PM -0700, Nuno Das Neves wrote:
> The definition conflicts with one added in hvgdk.h as part of the mshv
> driver so must be moved to hyperv-tlfs.h.
> 
> This structure should be in hyperv-tlfs.h anyway, since it is part of
> the TLFS document.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
