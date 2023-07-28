Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428DC76657D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 09:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjG1HkX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 03:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjG1HkU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 03:40:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A4D2D73;
        Fri, 28 Jul 2023 00:40:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690530018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3lFFYmxXQsCGkR7WqgUDzZWwO7vYvbu+VSipk5DNPA=;
        b=dOnUWXAMBHlcF7DznBkjH1bNSRZt+A6Mltw6RDp2xMdbpTnFdfZBI3y1RDIiQndh8norCs
        xgaR6VqxfVHeggOYHmhBxPMiDlAaLCNYfZR3VoDu25WsUpWOUPH0WgFJ/oAPIEC2pSTIYe
        k438ON5htB+OEfFOxqneM4VHIeGVLIQXPSwi0j/birbgYbTwS1aQ+m90UQ4lMluYbs5a49
        M6C8x3aTtTkqVg8sAoRWE5LZY7sFQKgQFWOmmAQa3RF/RMgRRb6yiD79UNeahJrVQ3wKlA
        0ofotDXP5emQXeBeW6E7GiF2jWptWbCnD7GI9BgBZcRP7c4Ux94kdXRBfdkb+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690530018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3lFFYmxXQsCGkR7WqgUDzZWwO7vYvbu+VSipk5DNPA=;
        b=Ve9ftLHdXNIrLTDWdMIvBVbeE5nyJztICBjwg4I7sZqU1LICnyGJbPbsQ6R9RRc5HsYj6c
        XRpOJBT5fqzZ3UCg==
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "ldufour@linux.ibm.com" <ldufour@linux.ibm.com>
Cc:     "npiggin@gmail.com" <npiggin@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] Introduce SMT level and add PowerPC support
In-Reply-To: <c66e3e800a7d257ef7a90749fe567f056f4c3ace.camel@intel.com>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
 <c66e3e800a7d257ef7a90749fe567f056f4c3ace.camel@intel.com>
Date:   Fri, 28 Jul 2023 09:40:17 +0200
Message-ID: <87wmykqyam.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Rui!

On Sun, Jul 09 2023 at 15:25, Rui Zhang wrote:
> I ran into a boot hang regression with latest upstream code, and it
> took me a while to bisect the offending commit and workaround it.

Where is the bug report and the analysis? And what's the workaround?

Thanks,

        tglx
