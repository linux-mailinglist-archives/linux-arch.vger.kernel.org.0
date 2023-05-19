Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C367095DD
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 13:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjESLFE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 07:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjESLFC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 07:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B7E10F3;
        Fri, 19 May 2023 04:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F937656AE;
        Fri, 19 May 2023 11:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37386C433D2;
        Fri, 19 May 2023 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684494276;
        bh=7ECRcKgwCdyyTgDBbJz0zfr1+MHn2oRz/WMFm82eUgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYIHI3O/ukDbC0JJEKE54/DYeU/wAF3SvmrKeZAiqGvL3K3SBC0MNpHvYqe7DVx+N
         6GU3h+6qL68gk0a7MjdQ61JMaGO0SJpZS6vltmcdVN2VP+wXgz6omdFaKihVKIQ6WV
         cSGeefn9Cec0eBSjPvrbpALM8nmHNL9Uof6aYsGbRh4e6VCiH2TUAd34XBucA26cfl
         NfuFO2sblCy69w9PyOO2CjWrAFciMslywAztINCVB/92zevnoynu44LvORUK5YgGtp
         LTw3VlSQWGlyFNUXynNmQsks5fq7gHrA84JwnvPfYk6kgmcSzM7XIlbaGk8AGi1+yN
         C9ndWmCjaH1Ug==
Date:   Fri, 19 May 2023 13:04:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/3] selftests: net: add SCM_PIDFD /
 SO_PEERPIDFD test
Message-ID: <20230519-zenit-schmieden-7f2aaa22ab08@brauner>
References: <20230517113351.308771-1-aleksandr.mikhalitsyn@canonical.com>
 <20230517113351.308771-4-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517113351.308771-4-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 17, 2023 at 01:33:51PM +0200, Alexander Mikhalitsyn wrote:
> Basic test to check consistency between:
> - SCM_CREDENTIALS and SCM_PIDFD
> - SO_PEERCRED and SO_PEERPIDFD
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
> v3:
> 	- started using kselftest lib (thanks to Kuniyuki Iwashima for suggestion/review)
> 	- now test covers abstract sockets too and SOCK_DGRAM sockets

Thanks for adding tests!
