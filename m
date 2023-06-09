Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9A372923E
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 10:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbjFIIHS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 04:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjFIIHD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 04:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782E530EC;
        Fri,  9 Jun 2023 01:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CC8C65458;
        Fri,  9 Jun 2023 08:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495D5C433EF;
        Fri,  9 Jun 2023 08:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686297984;
        bh=VbZVxaGPaRsw6JvGUSTbVpf9AHBEjjB7Txf6NpcNiDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isyL61hXblRasPl4TUYSr4DLYgRNKmTm4sur8grg95rnbuWHgqvSppAptmviYlZax
         qpZkWJRj7YOwi9UadXQBzDt1NbjwKcGUB7WroS9hu4q0XoYo2PkU/A70SwjSzTxzBu
         8r2xDrdqTECGRdGTW8IUUCjFVpDGdrtbWfI0sarH2AJbzJ+wKjcCvEWSMkPgznclF0
         QZlEs2Jh9oDaCC8BLwaamKHheRNtPt04Ez+A/3mn0yFyeE735lSvVSOVOuoj75NdEO
         5yjaoNqfu05UPxfT0PQ5Y9WBnLr6ptcAMjKs5ZlhyDCkj2XSdIFh3OjkkNMnpFhNBb
         BOZtM/PjPDYFw==
Date:   Fri, 9 Jun 2023 10:06:13 +0200
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
        Lennart Poettering <mzxreary@0pointer.de>,
        Luca Boccassi <bluca@debian.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/4] af_unix: Kconfig: make CONFIG_UNIX bool
Message-ID: <20230609-geordert-biegen-51294566232b@brauner>
References: <20230608202628.837772-1-aleksandr.mikhalitsyn@canonical.com>
 <20230608202628.837772-5-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608202628.837772-5-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 08, 2023 at 10:26:28PM +0200, Alexander Mikhalitsyn wrote:
> Let's make CONFIG_UNIX a bool instead of a tristate.
> We've decided to do that during discussion about SCM_PIDFD patchset [1].
> 
> [1] https://lore.kernel.org/lkml/20230524081933.44dc8bea@kernel.org/
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
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
