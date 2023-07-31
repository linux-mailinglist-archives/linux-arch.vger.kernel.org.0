Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDD676927C
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjGaJ5E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 05:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGaJ4q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 05:56:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942EEE49;
        Mon, 31 Jul 2023 02:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2852360C20;
        Mon, 31 Jul 2023 09:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7506C433C8;
        Mon, 31 Jul 2023 09:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690797388;
        bh=r6d0QvBm5c3aVqIjW/FjofLf6a13RLH6NmOQw7Kne68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYf2e2k2bvNFUNfHRA7/KmU1Qs9xCMChe2rHHHCrlhiMgB8lzjmPhSkk2Ba5+Upwz
         sb9HnepDhjH0fIaoNcj6rZZMTomzNxJSJv232Q5A1hDDv+VNQ9Vs0XM8LtIq9Yt9GX
         f4kohnPm2aQA1MmU48jz+StoQ+lQ7n1pp7f1OW8NYfQKGRMxvBnEIbr0+Q9kE+r9Fs
         XIPNF/vfUtWtIDku22RV9vAJKoGuhO4y8/Sw4MC2AeL/ZNPW/Uoe2iKEqdmeH3sJdM
         t5UuHOZTO2m1nHkvH8H0uKhm+Y8M5QXaf9iXqcjLUBLQKBblWEDNOph4LYTy+BzBxA
         6Bd9Dpym9xRgA==
Date:   Mon, 31 Jul 2023 10:56:23 +0100
From:   Will Deacon <will@kernel.org>
To:     guoren@kernel.org
Cc:     David.Laight@ACULAB.COM, peterz@infradead.org, mingo@redhat.com,
        longman@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2] asm-generic: ticket-lock: Optimize
 arch_spin_value_unlocked
Message-ID: <20230731095622.GA24621@willie-the-truck>
References: <20230731023308.3748432-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731023308.3748432-1-guoren@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 30, 2023 at 10:33:08PM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The arch_spin_value_unlocked would cause an unnecessary memory
> access to the contended value. Although it won't cause a significant
> performance gap in most architectures, the arch_spin_value_unlocked
> argument contains enough information. Thus, remove unnecessary
> atomic_read in arch_spin_value_unlocked().
> 
> The caller of arch_spin_value_unlocked() could benefit from this
> change. Currently, the only caller is lockref.
> 
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
> Changelog
> V2:
>  - Fixup commit log with Waiman advice.
>  - Add Waiman comment in the commit msg.
> ---
>  include/asm-generic/spinlock.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

It would be nice to see some numbers showing this actually helps, though.

Will
