Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFA0513D5C
	for <lists+linux-arch@lfdr.de>; Thu, 28 Apr 2022 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352205AbiD1VXv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Apr 2022 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiD1VXu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Apr 2022 17:23:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B8E237D0;
        Thu, 28 Apr 2022 14:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CBF461F3B;
        Thu, 28 Apr 2022 21:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 971E1C385A9;
        Thu, 28 Apr 2022 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651180833;
        bh=Ef4FdoAUs1E4p1l6Hja12/6MqX5sUBzOSTh36QSsHUs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PvJf5VNsAiwEEl+vN+Ona8Ega6nbsskrRFIaGDmCt8u+3ie0c0acYxbnknCNsR0Bh
         Z7SdcUl7fYrLFDC1HynZByWdQAVzKBCX2HJBIBrBEYou8uV9xWvwCGFZAIW57FIO0o
         GRDRcQ2z1wQobFUYriYvXpzgusR5OSLGWS/ngtW6uHGTbQafuosH2/cmP4byzVeG0Y
         BCGIiZE9QqdfyNsvOn3112nZIS6iiMV4LEhZkmeraZXkJpZiBL8QMkrn43CBEZRNxy
         Sd7YKkLYgoORVYhpcRiI6byqtMfmpchN5ERubjggc+usqJhFCGC5qST6GIHW2biIvF
         ck552V83iEtNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 706E1F03870;
        Thu, 28 Apr 2022 21:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: SO_RCVMARK socket option for SO_MARK with
 recvmsg()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165118083345.15958.2167314191776902298.git-patchwork-notify@kernel.org>
Date:   Thu, 28 Apr 2022 21:20:33 +0000
References: <20220427200259.2564-1-lnx.erin@gmail.com>
In-Reply-To: <20220427200259.2564-1-lnx.erin@gmail.com>
To:     Erin MacNeil <lnx.erin@gmail.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, arnd@arndb.de, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        socketcan@hartkopp.net, mkl@pengutronix.de, robin@protonic.nl,
        linux@rempel-privat.de, kernel@pengutronix.de,
        alex.aring@gmail.com, stefan@datenfreihafen.org,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        jk@codeconstruct.com.au, matt@codeconstruct.com.au,
        vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, edumazet@google.com, lmb@cloudflare.com,
        ptikhomirov@virtuozzo.com, m@lambda.lt, hmukos@yandex-team.ru,
        sfr@canb.auug.org.au, weiwan@google.com, yangbo.lu@nxp.com,
        fw@strlen.de, tglx@linutronix.de, rpalethorpe@suse.com,
        willemb@google.com, liuhangbin@gmail.com, pablo@netfilter.org,
        rsanger@wand.net.nz, yajun.deng@linux.dev,
        jiapeng.chong@linux.alibaba.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
        linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Apr 2022 16:02:37 -0400 you wrote:
> Adding a new socket option, SO_RCVMARK, to indicate that SO_MARK
> should be included in the ancillary data returned by recvmsg().
> 
> Renamed the sock_recv_ts_and_drops() function to sock_recv_cmsgs().
> 
> Signed-off-by: Erin MacNeil <lnx.erin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: SO_RCVMARK socket option for SO_MARK with recvmsg()
    https://git.kernel.org/netdev/net-next/c/6fd1d51cfa25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


