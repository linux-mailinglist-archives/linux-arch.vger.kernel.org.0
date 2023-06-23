Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BF673B721
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jun 2023 14:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjFWMZ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jun 2023 08:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFWMZ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jun 2023 08:25:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2671A1FCE;
        Fri, 23 Jun 2023 05:25:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A88FF61A38;
        Fri, 23 Jun 2023 12:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5498C433C8;
        Fri, 23 Jun 2023 12:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687523155;
        bh=xwSl00aaRAfiJKxykoKczzBMPG2eee6QLKUurUHxVV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sj1Ql0R3SD/pai44v68uY1yoIEcM+LN+oOVC4wkMR9MLmZH5qEsp7c8aYgqAesMHI
         uppUwkpd/caKvlQD3wsorLrmPKmfVFzrAmgqNRyW95CxYo752T4up40Y93QFv/a6y+
         Kc8E935vpOp/PU/0qj2sR+tPaDKTCXqD3tOf4QcdM1QnoX062j7Sw4pklz6rxUGkm9
         zDTtSZYwpM0WEuwupwIdKpa7cIv4LkqKuOA2wcsKVArqHb2isX5ya58Vn1mkK/SJ8s
         eiZog9etZmON+uXR9zqG5pSKY/c0Wkz0B1RcIjCJzZo+GItnck/wgrwTDJhvq9qsV2
         NYIr4g1NisWng==
Date:   Fri, 23 Jun 2023 14:25:50 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] syscalls: Remove file path comments from headers
Message-ID: <20230623-kalkulation-bangen-c6d30d1423a5@brauner>
References: <e1a2665d-2e11-7722-a7ae-ef534829ed37@intel.com>
 <20230621223600.1348693-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230621223600.1348693-1-sohil.mehta@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 21, 2023 at 10:36:00PM +0000, Sohil Mehta wrote:
> Source file locations for syscall definitions can change over a period
> of time. File paths in comments get stale and are hard to maintain long
> term. Also, their usefulness is questionable since it would be easier to
> locate a syscall definition using the SYSCALL_DEFINEx() macro.
> 
> Remove all source file path comments from the syscall headers. Also,
> equalize the uneven line spacing (some of which is introduced due to the
> deletions).
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
