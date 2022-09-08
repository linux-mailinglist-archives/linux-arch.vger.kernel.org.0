Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6E65B14D9
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 08:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIHGkQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Sep 2022 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiIHGjz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Sep 2022 02:39:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706AB2A709;
        Wed,  7 Sep 2022 23:39:50 -0700 (PDT)
Date:   Thu, 8 Sep 2022 08:39:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662619188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCklRcd8QH5yU0ZLfjm8Su6BvKGC7lByKatEzlg7GMg=;
        b=R2yS+AzL/DDj+5QU94usdh7eQJwUIEckdiB1lqs0ce4CBBxLfqUzXlJ/dKkRNKnPN66u0W
        QmhCUV6KTMJIo0a+Q1bVKnAqPa1GB/QnZ713vzd9iqHaYUnA0nVYNY9zgc1s9iz3/c7NDc
        Es253i48vXvUMpvFNnFl2A0wrb+NFspdsYY7Xc6XOvFTRsiL+S+RLpENX2KPfcv5xAZnG1
        6GEP+2ad6+PqE5d10yDRTMz5HKIwdpGT1m4ybgQ1+dNBhHnNXopGZCpGY76vVE+aOhAneT
        ETlJf/CV2OtewNZDfEnCHUTnTeLmBslI+pOvFpYnHqkc6m0Kup4yYuiNJ42Guw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662619188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCklRcd8QH5yU0ZLfjm8Su6BvKGC7lByKatEzlg7GMg=;
        b=/EZcb9cquB9zayRZl/wGva2AWN9cX8veY4ISar2D2givsMxB+ZJyy99I3UUb/GQNj1IPaT
        Ahl7ZOOb20p7PlCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 REPOST] asm-generic: Conditionally enable
 do_softirq_own_stack() via Kconfig.
Message-ID: <YxmOMxxeC/h7L1EW@linutronix.de>
References: <Ywcx4QBdYNIBLJiy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Ywcx4QBdYNIBLJiy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-08-25 10:25:06 [+0200], To Arnd Bergmann wrote:
> Remove the CONFIG_PREEMPT_RT symbol from the ifdef around
> do_softirq_own_stack() and move it to Kconfig instead.
>=20
> Enable softirq stacks based on SOFTIRQ_ON_OWN_STACK which depends on
> HAVE_SOFTIRQ_ON_OWN_STACK and its default value is set to !PREEMPT_RT.
> This ensures that softirq stacks are not used on PREEMPT_RT and avoids
> a 'select' statement on an option which has a 'depends' statement.
>=20
> Link: https://lore.kernel.org/YvN5E%2FPrHfUhggr7@linutronix.de
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>=20
> Arnd, could you please route it via your tree?=20
>=20
> v1=E2=80=A6v2:
>    - Use "def_bool HAVE_SOFTIRQ_ON_OWN_STACK && !PREEMPT_RT"

a gentle *ping*

Sebastian
