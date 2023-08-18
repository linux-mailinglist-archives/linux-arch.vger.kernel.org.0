Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1218C7815CB
	for <lists+linux-arch@lfdr.de>; Sat, 19 Aug 2023 01:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbjHRXYR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 19:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242579AbjHRXYQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 19:24:16 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9BA4205;
        Fri, 18 Aug 2023 16:24:15 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-688731c6331so1204098b3a.3;
        Fri, 18 Aug 2023 16:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692401055; x=1693005855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNywJLT9Zeb+aU5QBwgeatkpR3WL+zSNxCwRayoHWcE=;
        b=CA0kZBhiXsKi7EyHnUskZiNt6OR+MjXsMBFSqhIUIyREgs9syeF1gbKSJiQayxBTVM
         GLuTXdG3ZWXCSH18bqxrkFH4SeZVLkPSVR3qKE3yV+rzlHvwqeqymMEOo0dMdES7LA0C
         6+7eEnFdiTLQWP12r5sN0Y7I+8coGCkyMEiBgLXRNx40iIsN3DuMY/eePKl3hs7uhZwj
         BqgQrhw/iXeXjNupLjjP06Rds2HQmg1dMdv5WWkVOPm8D/b6e4/izKFUzQSbcioXWajq
         s4PUjwkr9rqHhq7YV0GKi1w3XKRH22APfiJEjHcbc1/7twG725T3gGtPQig+HrM18FLE
         ncYw==
X-Gm-Message-State: AOJu0YyBvkvaemPu/8AlHFU2W290K94X0L9AaLipQUnknUMDZNw8CtFw
        DTfATxQ0J6vf+9QouNl+i5E=
X-Google-Smtp-Source: AGHT+IHICoDj+Bu8qaZ0k8/jKJTzFsmF4iLDzjapo9tqi6IHWto2QdWi5Mwpo6ob7C97GSpV6rcrfg==
X-Received: by 2002:a05:6a00:188f:b0:688:7948:6978 with SMTP id x15-20020a056a00188f00b0068879486978mr831088pfh.2.1692401054562;
        Fri, 18 Aug 2023 16:24:14 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id b1-20020aa78701000000b0068895d26b79sm2118207pfo.10.2023.08.18.16.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 16:24:14 -0700 (PDT)
Date:   Fri, 18 Aug 2023 23:23:56 +0000
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
Subject: Re: [PATCH v2 09/15] Drivers: hv: Introduce hv_output_arg_exists in
 hv_common.c
Message-ID: <ZN/9jBNZYtLdYe+m@liuwe-devbox-debian-v2>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-10-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692309711-5573-10-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 17, 2023 at 03:01:45PM -0700, Nuno Das Neves wrote:
> This is a more flexible approach for determining whether to allocate the
> output page.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
