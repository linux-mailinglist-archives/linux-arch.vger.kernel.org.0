Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC425EEAD6
	for <lists+linux-arch@lfdr.de>; Thu, 29 Sep 2022 03:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiI2BSs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 21:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI2BSq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 21:18:46 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0863B11CB2B;
        Wed, 28 Sep 2022 18:18:43 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id F01261E80D70;
        Thu, 29 Sep 2022 09:14:16 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OpYEFikbSp93; Thu, 29 Sep 2022 09:14:14 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 9E2C71E80D4B;
        Thu, 29 Sep 2022 09:14:12 +0800 (CST)
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
Subject: Re: [PATCH v6] hyperv: simplify and rename generate_guest_id
Date:   Thu, 29 Sep 2022 09:18:33 +0800
Message-Id: <20220929011834.2595-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <YzRSCSOIhHQ9JYmr@liuwe-devbox-debian-v2>
References: <YzRSCSOIhHQ9JYmr@liuwe-devbox-debian-v2>
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


Thank you very much for your help, and thank the members of the mailing list (in the sending list). With your help, I learned more standard patch writing method and patch modification ideas.

thanks,
kunyu.

