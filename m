Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC06229224
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 09:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgGVHez (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 03:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGVHez (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 03:34:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4403C0619DC;
        Wed, 22 Jul 2020 00:34:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595403292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e238TGtYSTJU/Nj4nz8uM/OcqtGfTu5cp+moDbUUjKo=;
        b=AeuhoWxQOdrudw5w1KzhY7xrOY5NgpVfvove3vHqfArVfKbJASD64AhJSezNITqXsykKmA
        OeD4oT8t/yR/sR46YfLes0xUmzLU/g0+HBx7vTuCyTMwe1c76XsKYIssmokHgxcooubmqa
        tlKFlg7z8+LPAXq9qKOGWYT3d3TYFcw+hBM3BaZ3eHOVXfOu2qb9ZOR7wW/dMpuAVbl6IL
        D/JHxH5SdNmyu5y8tFWjkCPv8SjyE37XWeAw46Eip49nmel1DDsiq+mrSCYRsQrJfL5Du2
        IJuvu26bvZSRxQhc9yV9KsO/qag4b89u2xX70oJFfWlcJ/f6KBm04MYIHBYDBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595403292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e238TGtYSTJU/Nj4nz8uM/OcqtGfTu5cp+moDbUUjKo=;
        b=xnni68CJ501/RLGRfwNcocBgzDg8uBhVTvntbkUEUifL/e360iM0lFQn44NybsFp4PB6/S
        Sx3oSXKhjNdeDxDg==
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V4 02/15] entry: Provide generic syscall entry functionality
In-Reply-To: <202007211426.B40A7A7BD@keescook>
References: <20200721105706.030914876@linutronix.de> <20200721110808.455350746@linutronix.de> <202007211426.B40A7A7BD@keescook>
Date:   Wed, 22 Jul 2020 09:34:51 +0200
Message-ID: <87o8o82eas.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Tue, Jul 21, 2020 at 12:57:08PM +0200, Thomas Gleixner wrote:
>> --- /dev/null
>> +++ b/kernel/entry/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_GENERIC_ENTRY) += common.o
>
> But, my point is, let's avoid tripping over this again, and retain the
> disabling here:
>
> CFLAGS_common.o += -fno-stack-protector
>
> I can add this again later, but it'd be nice if it was done here to
> avoid gaining back the TIF_WORK stack protector overhead penalty (which
> we're free of in v5.8 for the first time). ;)

Duh, yes. I completely forgot about that.

Thanks for spotting it!

       tglx
