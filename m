Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1EC71107D
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 18:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjEYQJT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 12:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjEYQJR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 12:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0774CE4A;
        Thu, 25 May 2023 09:08:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5360B61757;
        Thu, 25 May 2023 16:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5F6C433EF;
        Thu, 25 May 2023 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685030925;
        bh=yLNmU6oM5rYoi5bPYZ/1slw69C0cgZhSY5hlcUA5fLw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Bu7qXz//675tf5qYPE/GYQkvDL0wEkK4QF/4oVCwgjKzAF7dkBEN0QLTxDylDHISb
         5RZrMsrBMGLWEmbz62O3KAnacy3+YjbfzuLTcVCgUvYPGfDg+toCJHFVJ4le5xcSmJ
         a+9exhF5fAeDvnUbEBtH1ONGYujt5o/ThXx38F4nhgwwbSA/RHgx4/fJavoct6E1Ll
         phsxg0+tMYGVUkFEfZdqU8gk31GNHA7fvw19BMPW6/Qts421gsq0kS+44mCI754Tt3
         fnayGxDEg7B0q1k/ltESgbFqWmjF5sUnDEbb3v5ps4dzqN1Hja8KvDTK09v6B9HdzH
         zbqQxOOExmERw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v5,43/44] wifi: add HAS_IOPORT dependencies
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230522105049.1467313-44-schnelle@linux.ibm.com>
References: <20230522105049.1467313-44-schnelle@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jouni Malinen <j@w1.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168503091986.22756.11469892190478443875.kvalo@kernel.org>
Date:   Thu, 25 May 2023 16:08:41 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Acked-by: Kalle Valo <kvalo@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Patch applied to wireless-next.git, thanks.

040a22191879 wifi: add HAS_IOPORT dependencies

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230522105049.1467313-44-schnelle@linux.ibm.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

