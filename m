Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FA77AB995
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 20:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjIVStG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Sep 2023 14:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjIVStF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2023 14:49:05 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C52FB7;
        Fri, 22 Sep 2023 11:48:58 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-68cbbff84f6so2925173b3a.1;
        Fri, 22 Sep 2023 11:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408538; x=1696013338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL5bEyIdwLqLeBmJpTNF22yRvuv3aGh3Q9CwJkae028=;
        b=cfqbslfLC7cRfJNvdd5xYsFSc9LDayjcTlHdDlhKRwFL2fE8LUJL7lSVxag19jYlJ4
         SdnFMtMUAKtuEc/drAqxk9ZCq7PGe5u41QMKweifiJTxJlAgYvMC2tZzgCRMsdKPHPJs
         6nqxiR0e3g2J0ofr6x7flTB8pynBUXondIuoZtHlbedMvjXxq69dzS7wCbW4Jg6LNaAZ
         eDKmespwnnYYKPPzit/scIx8fR6y25XUxsiQAWL20c0m1HNfD0BcQFBvuR0kHUr9MW/e
         gDvrfY8PTOkMsFNK/h9UoEIp7KDRKv3bREh964xhE7oTfciqTiEauYpV55XKCqSrAsoY
         YENg==
X-Gm-Message-State: AOJu0YxZh2uLBddPRq2hGZoveI/eJ81APf0wXTGXJEOgDj5MYqd5CE5n
        L+qjScmc17R89AC81GV0Bpg=
X-Google-Smtp-Source: AGHT+IHH3V+wn81SPydKnVucq6fioEnuRLf9tOh/vQim6/QBf0odXijPI8phhlNSwrYfPzOStF+8kA==
X-Received: by 2002:a05:6a21:7891:b0:152:4615:cb9e with SMTP id bf17-20020a056a21789100b001524615cb9emr696294pzc.13.1695408537936;
        Fri, 22 Sep 2023 11:48:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id q17-20020a637511000000b00570574feda0sm3473414pgc.19.2023.09.22.11.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:48:57 -0700 (PDT)
Date:   Fri, 22 Sep 2023 18:48:14 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        gregkh@linuxfoundation.org, haiyangz@microsoft.com,
        decui@microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH v3 12/15] Documentation: Reserve ioctl number for mshv
 driver
Message-ID: <ZQ3hbhOJdjbveIUH@liuwe-devbox-debian-v2>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-13-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695407915-12216-13-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 22, 2023 at 11:38:32AM -0700, Nuno Das Neves wrote:
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Acked-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Wei Liu <wei.liu@kernel.org>
