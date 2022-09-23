Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490895E7948
	for <lists+linux-arch@lfdr.de>; Fri, 23 Sep 2022 13:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiIWLT5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Sep 2022 07:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiIWLT4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Sep 2022 07:19:56 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 240CE3C150;
        Fri, 23 Sep 2022 04:19:54 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id AAD011E80D94;
        Fri, 23 Sep 2022 19:16:17 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sx5Fz_JcXolB; Fri, 23 Sep 2022 19:16:15 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id E1A5A1E80D74;
        Fri, 23 Sep 2022 19:16:14 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     wei.liu@kernel.org
Cc:     arnd@arndb.de, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, decui@microsoft.com,
        haiyangz@microsoft.com, hpa@zytor.com, kunyu@nfschina.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        sthemmin@microsoft.com, tglx@linutronix.de, will@kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2] asm-generic: Remove the parameters of the generate_guest_id function and modify the return type and modify the function name
Date:   Fri, 23 Sep 2022 19:19:38 +0800
Message-Id: <20220923111939.2584-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <Yy2KVM08HMiv46d6@liuwe-devbox-debian-v2>
References: <Yy2KVM08HMiv46d6@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Thank you very much, I re-edited the content and released it according to v3.

