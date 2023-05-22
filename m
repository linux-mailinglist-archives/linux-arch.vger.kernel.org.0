Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2047A70CB23
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 22:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjEVUeS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 16:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjEVUeP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 16:34:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41467121;
        Mon, 22 May 2023 13:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2FD862BCB;
        Mon, 22 May 2023 20:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83299C433D2;
        Mon, 22 May 2023 20:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684787651;
        bh=0N5ujlws6muMcuISdvNwKEBan06V8ul27Fqz3m4Odnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JV6R8zU24ZJEqo4ZBm2nq4gkyJastGUa/aWU+mkcudCYp1Fa8N+X8REo36DFPU7Bi
         OYfy+X7+TGQDvt0uVlZTVWHx77I9faM6ACVsGs58PYMxtP0SkXqYWTo6WbBL6715fO
         3MTLyVaRODvWKJu0gpEwSsnfuhkuQQqt2YUQWVDGlyJf4LMQ55UlXb9IsI3xKeGtro
         Ue11yNL5WtyUwsxlVNjZUybljAstpbRoxpz8CkW0NP1YuSgN1KJsyfAyNTfLc5Tk9G
         bunR2kzIS4AgR20jnxX3E+sjBsTp3VO+zwjn+bPEb15jvYvMUX+AnpoZcmktKE0DM/
         +8j+ZRrF4y7xw==
Date:   Mon, 22 May 2023 13:34:09 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Luca Boccassi <bluca@debian.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/3] scm: add SO_PASSPIDFD and SCM_PIDFD
Message-ID: <20230522133409.5c6e839a@kernel.org>
In-Reply-To: <20230522132439.634031-2-aleksandr.mikhalitsyn@canonical.com>
References: <20230522132439.634031-1-aleksandr.mikhalitsyn@canonical.com>
        <20230522132439.634031-2-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 22 May 2023 15:24:37 +0200 Alexander Mikhalitsyn wrote:
> v6:
> 	- disable feature when CONFIG_UNIX=n/m (pidfd_prepare API is not exported to modules)

IMHO hiding the code under #if IS_BUILTIN(CONFIG_UNRELATED) is
surprising to the user and.. ugly?

Can we move scm_pidfd_recv() into a C source and export that?
That should be less controversial than exporting pidfd_prepare()
directly?
