Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15D74B632C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 06:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiBOFzu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 00:55:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBOFzt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 00:55:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205475601
        for <linux-arch@vger.kernel.org>; Mon, 14 Feb 2022 21:55:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E1CF614C8
        for <linux-arch@vger.kernel.org>; Tue, 15 Feb 2022 05:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F07BC340EC;
        Tue, 15 Feb 2022 05:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644904539;
        bh=9uB90piUu431HgtFLNXFLmwOsGMLYUhKvy1qd8ij8J4=;
        h=Date:From:To:Cc:Subject:From;
        b=F2yJv030QeD8fhjrggj1RhRlBhzDrxbEShgkOJCnRsICze/lEwhf0xyFPb48rguvm
         c1noR+2rhdp/7jlbCbSbfLyLWKvzm2+lCgr37LBUWYQP6T7DCn3STz4L6zqJNwpodt
         Vtdkhd7nmbmZ20fjocOQE0UApJeb566gjtwXUob3u9y3y+coLMkPCNTdK4DivueGIS
         lVAKrGPDIlzpe9MGskdh6nnX2Xi89aHuI93ZRvrW9qi9GOPpqtReacj1vbFM7yIy9w
         LruFM1zTtECDIoUJOzBTYoKRQYIWHlEM/aS+mooYPS+x3+b5w/TYU7SpcPpYhlT8/Q
         t2Un4rm4wcRCA==
Date:   Tue, 15 Feb 2022 07:55:32 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: linux/arch micronference @ plumbers 2022
Message-ID: <YgtAVP4gXH3Be+O0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

I'd like to re-start arch microconference at Linux Plumbers [1] this year.

Here's my draft of the proposal, feedback would be appreciated.

I only CC'ed the linux-arch list to avoid overly long distribution list.
Feel free to add particular people.

[1] https://lpc.events

linux/arch microconference
==========================

Historically, the code in arch/ was developed for one architecure and then
copied and adjusted by others. This created a lot of duplicated or almost
duplicated code with subtle differences which prevents easy refactoring and
consolidation.

The linux/arch microconference aims to bring architecutre maintaners in one
room to discuss how the code in arch/ can be improved, consolidated and
generalized, at least where it makes sense.

The discussion at the previous linux/arch microconfernece in 2020 lead to
updates in RISC-V kprobes implementation [1], removal of DISCOTIGMEM memory
model [2] and enablement of generic entry on s390 [3].

[1] https://git.kernel.org/torvalds/c/c22b0bcb1dd0
[2] https://git.kernel.org/torvalds/c/bb1c50d3967f
[3] https://git.kernel.org/torvalds/c/56e62a737028

The possible topics could be:

- reducing code duplication and generalizing the common code in arch/
- making headers in include/asm consistent
- on-boarding more architecures to use common entry code
- devicetree (unless they have their own microconf)
- identifying old machine support that may be either still in
  active use vs only in hobbyinst/retrocomputing vs completely
  obsolete and broken

MC Leads (tentative):
Mike Rapoport <rppt@kernel.org>
Arnd Bergmann <arnd@arndb.de>

-- 
Sincerely yours,
Mike.
