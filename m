Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9C87157E9
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 10:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjE3IGI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 04:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjE3IGH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 04:06:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E54A1;
        Tue, 30 May 2023 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685433966; x=1716969966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mXFIsJp/JCfN7PxbaXtUvSS1GRxHHE6VakHXbZbCvEs=;
  b=f0Z5m0VZlPcy/Xp/TuIV4Fuw6Z7tCqbUAMIrswilU0VkuvNFRMHF19UU
   Y5jpJ3PK22VCv7QM3qPUZHQQCuF5yUoB70XT0pAYpk0S2h1f1366Dg5W0
   sYbStJwIkMIpi8hyphMGmA+TuJh3GQa3juJxfnais3hkpM6HsQ9rEl8re
   ojr/Ckuxo6HE0pi7GFrisS4WnjUSb1AEYRAoCp+Vj/pqN9KEaXrB8o8Bh
   tkScc5vEW8p6iJfwitNty55U6aKYXuRM+z3+4gtKvKkWCdv501nWkFlKK
   ZWerFmloLTgnHFbb3CSFfwVbAZQqiNTMyw80iuRFTqGkQaORdsU2iwB4H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="418332051"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="418332051"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 01:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739426310"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739426310"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga001.jf.intel.com with ESMTP; 30 May 2023 01:06:04 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     willy@infradead.org, ryan.roberts@arm.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     fengwei.yin@intel.com
Subject: [PATCH 0/4] New page table range API fixup patches
Date:   Tue, 30 May 2023 16:07:27 +0800
Message-Id: <20230530080731.1462122-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZBho6Q6Xq/YqRmBT@casper.infradead.org>
References: <ZBho6Q6Xq/YqRmBT@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These are fixup patches for Matthew's New page table range API
patchset.

Thanks Matthew and Ryan a lot for helping on these fixup patches.
I sent the patches to Matthew and Ryan in private mail. Later,
realized that private mail should be avoid.


Yin Fengwei (4):
  filemap: avoid interfere with xas.xa_index
  rmap: fix typo in folio_add_file_rmap_range()
  mm: mark PTEs referencing the accessed folio young
  filemap: Check address range in filemap_map_folio_range()

 mm/filemap.c | 39 ++++++++++++---------------------------
 mm/memory.c  |  2 +-
 mm/rmap.c    |  2 +-
 3 files changed, 14 insertions(+), 29 deletions(-)

-- 
2.30.2

