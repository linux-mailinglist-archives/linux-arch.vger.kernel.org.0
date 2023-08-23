Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC4C785774
	for <lists+linux-arch@lfdr.de>; Wed, 23 Aug 2023 14:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjHWME7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Aug 2023 08:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjHWMEi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2023 08:04:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A451984;
        Wed, 23 Aug 2023 05:04:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4d44K0Pz4x2L;
        Wed, 23 Aug 2023 22:04:08 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <20230806150954.394189-1-masahiroy@kernel.org>
References: <20230806150954.394189-1-masahiroy@kernel.org>
Subject: Re: [PATCH 1/3] powerpc: remove unneeded #include <asm/export.h>
Message-Id: <169279175566.797584.2539796704506520702.b4-ty@ellerman.id.au>
Date:   Wed, 23 Aug 2023 21:55:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 07 Aug 2023 00:09:52 +0900, Masahiro Yamada wrote:
> There is no EXPORT_SYMBOL line there, hence #include <asm/export.h>
> is unneeded.
> 
> 

Applied to powerpc/next.

[1/3] powerpc: remove unneeded #include <asm/export.h>
      https://git.kernel.org/powerpc/c/3eb3f168e83aa7a7b8477507cf4b08b9515b4b13
[2/3] powerpc: replace #include <asm/export.h> with #include <linux/export.h>
      https://git.kernel.org/powerpc/c/393261828740c3ed95fc810c3f4c1018b86af7e5
[3/3] powerpc: remove <asm/export.h>
      https://git.kernel.org/powerpc/c/efa1f85019537ce44832cf73a6db18611e3e41cd

cheers
