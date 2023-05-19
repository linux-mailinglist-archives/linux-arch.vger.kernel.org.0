Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B907095C1
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 13:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjESLDW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 07:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjESLDO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 07:03:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4077E1BC8;
        Fri, 19 May 2023 04:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FA89656A0;
        Fri, 19 May 2023 11:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CC7C433EF;
        Fri, 19 May 2023 11:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684494145;
        bh=GDxqTee5RW45I+EsazKSKPRHRTJ5CXnT5tInfE2L01U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJ9J2xgoMZMzztWV6mbtOrS8Gzo8fhkw7c7l75Z5AfO4gF/zc3amswsdMzvX+SW3z
         nxJLD65h8PZw7xuQNIkGbktsCfA+XTf/28PypWquGX06Iljog8D6rwQraopCazdxxA
         zHvohR6i2FcDx16mQYwnyPFdSJCKcEk0bI6/mn3XRPdgCxb045bn58yYwh4zARkHsz
         6oYrYtyjuaeMtENrhIfcZEXiSRVY4AbB6KiB/YB2YDuhr0d+OOcAkcGqBxEaQCUGr5
         PpgmjLjE6GxnN0WLQxFhSn2QF6OkrS5UsifbObwZEOOlY2HGsNiT6Dcli+Sy00fyE3
         4JfMi5wxmYOgg==
Date:   Fri, 19 May 2023 13:02:18 +0200
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
Subject: Re: [PATCH net-next v5 1/3] scm: add SO_PASSPIDFD and SCM_PIDFD
Message-ID: <20230519-umkurven-fahrkarte-16085cfaa86d@brauner>
References: <20230517113351.308771-1-aleksandr.mikhalitsyn@canonical.com>
 <20230517113351.308771-2-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517113351.308771-2-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 17, 2023 at 01:33:49PM +0200, Alexander Mikhalitsyn wrote:
> Implement SCM_PIDFD, a new type of CMSG type analogical to SCM_CREDENTIALS,
> but it contains pidfd instead of plain pid, which allows programmers not
> to care about PID reuse problem.
> 
> Idea comes from UAPI kernel group:
> https://uapi-group.org/kernel-features/
> 
> Big thanks to Christian Brauner and Lennart Poettering for productive
> discussions about this.
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
> Tested-by: Luca Boccassi <bluca@debian.org>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
> v5:
> 	- no changes

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
