Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F325A661E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 16:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiH3OUe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 10:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiH3OUc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 10:20:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F315B044
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661869223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tORAGdOuIEyxqy7Xiz8FX0cV5xzTMMZWt6i8kmL4jMo=;
        b=BX/mMX2cQxwDZ+IpZi5A9q5sIH3BMRRPkOrfdHIy1deOXXF0MeEOruvsfpsroXZeCTRtcj
        bQtRNbMPcg+nLvkiZ1cfGCurNV4oGM6OlqMahWs5tFGVIFw8HuRToCq7vy+AJJvpBxXvEZ
        JGEPyl5oWmxwcaqTeqeV8/pEvCdLMJ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-l7kwZy8tMv2HEIQ0v8HnPw-1; Tue, 30 Aug 2022 10:20:17 -0400
X-MC-Unique: l7kwZy8tMv2HEIQ0v8HnPw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 897F1101A54E;
        Tue, 30 Aug 2022 14:20:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.123])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8D16B492C3B;
        Tue, 30 Aug 2022 14:20:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Aug 2022 16:20:12 +0200 (CEST)
Date:   Tue, 30 Aug 2022 16:20:07 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     guoren@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     vgupta@kernel.org, linux@armlinux.org.uk, monstr@monstr.eu,
        dinguyen@kernel.org, palmer@dabbelt.com, davem@davemloft.net,
        arnd@arndb.de, shorne@gmail.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org,
        openrisc@lists.librecores.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH 0/3] arch: ptrace: Cleanup ptrace_disable
Message-ID: <20220830142006.GA20935@redhat.com>
References: <20220830065316.3924938-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830065316.3924938-1-guoren@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 08/30, guoren@kernel.org wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This series cleanup ptrace_disable() in arch/*. Some architectures
> are duplicate clearing SYSCALL TRACE.
>
> Guo Ren (3):
>   riscv: ptrace: Remove duplicate operation
>   openrisc: ptrace: Remove duplicate operation
>   arch: ptrace: Cleanup ptrace_disable
>
>  arch/arc/kernel/ptrace.c        |  4 ----
>  arch/arm/kernel/ptrace.c        |  8 --------
>  arch/microblaze/kernel/ptrace.c |  5 -----
>  arch/nios2/kernel/ptrace.c      |  5 -----
>  arch/openrisc/kernel/ptrace.c   |  1 -
>  arch/riscv/kernel/ptrace.c      |  5 -----
>  arch/sparc/kernel/ptrace_32.c   | 10 ----------
>  arch/sparc/kernel/ptrace_64.c   | 10 ----------
>  kernel/ptrace.c                 |  8 ++++++++
>  9 files changed, 8 insertions(+), 48 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

