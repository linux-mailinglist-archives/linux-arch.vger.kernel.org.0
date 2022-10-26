Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D564560E280
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 15:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiJZNsc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Oct 2022 09:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiJZNsF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2022 09:48:05 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B6F29622E;
        Wed, 26 Oct 2022 06:47:56 -0700 (PDT)
Received: from anrayabh-desk.corp.microsoft.com (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id 80FFB2109251;
        Wed, 26 Oct 2022 06:47:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80FFB2109251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666792076;
        bh=20Y+/UZbV3iqb1Srh01Ko1r/lDYgX7VA4Hx6huHxYAM=;
        h=From:To:Cc:Subject:Date:From;
        b=mmO6qVa6s6H6SJRFSlCumPScWhScA0E9q+Hr95gnB7kvhIPvd4W0gVVhSZRUlBloU
         z0+M77hVu3mU8FBk2STM9vrRFEXV/fPJWB+czGAJCzbgOYcL6k06bj0XXfNSPG8u4A
         IFqgT9nBnnZeCxp+sNmUv5O1hJ865tMPaM6DVS4A=
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, daniel.lezcano@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, mail@anirudhrb.com
Subject: [PATCH 0/2] Fix MSR access errors during kexec in root partition
Date:   Wed, 26 Oct 2022 19:17:13 +0530
Message-Id: <20221026134715.1438789-1-anrayabh@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fixes a couple of MSR access errors seen during kexec in root partition
and opportunistically introduces a data structure for the reference TSC
MSR in order to simplify the code that updates that MSR.

Anirudh Rayabharam (2):
  x86/hyperv: fix invalid writes to MSRs during root partition kexec
  clocksource/drivers/hyperv: add data structure for reference TSC MSR

 arch/x86/hyperv/hv_init.c          | 11 +++++++----
 drivers/clocksource/hyperv_timer.c | 28 ++++++++++++++--------------
 include/asm-generic/hyperv-tlfs.h  |  9 +++++++++
 3 files changed, 30 insertions(+), 18 deletions(-)

-- 
2.34.1

