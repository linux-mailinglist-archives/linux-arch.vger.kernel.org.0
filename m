Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C75BD94F
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 03:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiITBWH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 21:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiITBWG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 21:22:06 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAB2C4F3B9;
        Mon, 19 Sep 2022 18:22:05 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 2FF121E80D93;
        Tue, 20 Sep 2022 09:18:59 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TtejZa5IMA9B; Tue, 20 Sep 2022 09:18:56 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 82BFB1E80D23;
        Tue, 20 Sep 2022 09:18:56 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     vkuznets@redhat.com
Cc:     haiyangz@microsoft.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.liu@kernel.org,
        zeming@nfschina.com
Subject: =?UTF-8?q?Re=3A=20=5BPATCH=5D=20asm-generic=3A=20Remove=20unnecessary=20=E2=80=980=E2=80=99=20values=20from=20guest=5Fid?=
Date:   Tue, 20 Sep 2022 09:21:58 +0800
Message-Id: <20220920012159.4047-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <878rmfpef8.fsf@redhat.com>
References: <878rmfpef8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Thank you very much for your suggestion. I will submit the new version after passing the test code.

