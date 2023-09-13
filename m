Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4350A79F3C1
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 23:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjIMV0M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 17:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjIMV0L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 17:26:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1901724;
        Wed, 13 Sep 2023 14:26:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694640365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n5SemyN5kTuRAKmINrdMjXAWMNiDJoht+kkIDxnpYo0=;
        b=yVnO36r0BGwIJBdtVI3/wZt5hNdBHYlKLk+UHjFdSBU56hZ47Nmo6/fSneKAcldUJ+nQz7
        ggVqyfYw/60fLrSm1Ya7fDYzlBIYhClTgYfkbTTwthdVzSyl0FPswB+hfcESR521b73uc/
        2VwPcawve1unQwLrEH7PpoZLESbDRcc20+qCtpWNa+32B3CMOMaLrfEqxOp6rUrAlxOrTa
        7n2+CF+/OVlkdUyLJBSWMsl3RRrfADZhY1kRp4bZHJKk1UVgGCtXP8b7gy5O1MDnYhbs5b
        NUQ8VjpUjTNwppqQTkACWBW82PNbnsciloX+n7OVGZ8qjIgkKwjyObs7c4SpMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694640365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n5SemyN5kTuRAKmINrdMjXAWMNiDJoht+kkIDxnpYo0=;
        b=/WAzP5hNM4UHzxLGYxLxTqA2litkixrCK6l6VHueKIgrb635W2NmfRcU1/MJhryTHZ9Pvb
        Q5KAUBAKbeDvCTAw==
To:     Ard Biesheuvel <ardb@google.com>, arnd@arndb.de
Cc:     linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [GIT PULL] Remove Itanium support
In-Reply-To: <20230911163129.3777603-2-ardb@google.com>
References: <20230911163129.3777603-2-ardb@google.com>
Date:   Wed, 13 Sep 2023 23:25:14 +0200
Message-ID: <87msxpzryd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 11 2023 at 16:31, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> ----------------------------------------------------------------
> Remove IA-64 architecture support
>
> Fix the IA-64 build before removing the architecture support completely.
> This makes v6.6 LTS the final Linux release with IA-64/Itanium
> support.

Good riddance. Can we remove more of these crufty architectures please?

Acked-by: Thomas Gleixner <tglx@linutronix.de>
