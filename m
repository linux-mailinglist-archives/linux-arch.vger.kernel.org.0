Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5AF103557
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2019 08:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfKTHm4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Nov 2019 02:42:56 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45043 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKTHm4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Nov 2019 02:42:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id q26so13778133pfn.11
        for <linux-arch@vger.kernel.org>; Tue, 19 Nov 2019 23:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=02fPVIRaO1XujNDxX9CuuJM8AmBmXK/c/uAOUSL7B7k=;
        b=D5sJ4Q1DZ+jmx2DVVm+1lddxjWMyscFIn0ZB/gaJuX/YWXSDnLWVB21GQ32sqegcRf
         1735ifZ8P8hOiEklKsS6kwdQLIvUpfn/DKVERKUpoGkGBB/u13X8qNp9FjzDc2YaGxw3
         A1uULK7fqhZ6Tlt2onYPaBEz6YkRDu+lZPWQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=02fPVIRaO1XujNDxX9CuuJM8AmBmXK/c/uAOUSL7B7k=;
        b=nQPmEbbAXOF7ITwdU3PWAvhxM2fhQXtyHHIOzLdGG7LDBHOAATui86CITbtMka3yAz
         sH4gj1Sr/iwUmemJPeHwzFWMPDuntPwxEojMGO9GmjjGIO8FFkc5Yd5gyKGUgZxshzPL
         Qfzs6D/uNVaBWHrSCkWvCnZaWPaulj5LOC5/0UM0X8qedf/Ir2s5MxZUk1Ezjy3DUP2T
         WZnvyRBrXZk4acITYRxOYcysrsW+uibtVM5P+UjN2ed0GnWMvnV/A/tXnzVTBuB8/JbI
         s4Po7b5jS1QIDmF1d/cLZGIN4fGmwWaQyfAyaV4mQ5TTd4drRAeMlEsdI3Bb8UVkLBS9
         dDgw==
X-Gm-Message-State: APjAAAWe6uHtpdu5HZCijE9SsETHdeuRhrUo8U3x0Lc6FoCli/bcZBC7
        wzf6NXGpq3OpO6S3fJxs1OxH6Q==
X-Google-Smtp-Source: APXvYqwm/x+WpaWJH4fsf1nTV8LKmnU/DjjJqE0nKakMSYxtLixOURk0cUOdKb/YWAirX92JzeUQPA==
X-Received: by 2002:a62:7847:: with SMTP id t68mr2372866pfc.140.1574235774458;
        Tue, 19 Nov 2019 23:42:54 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-9c57-4778-d90c-fd6d.static.ipv6.internode.on.net. [2001:44b8:1113:6700:9c57:4778:d90c:fd6d])
        by smtp.gmail.com with ESMTPSA id 186sm31138852pfb.99.2019.11.19.23.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 23:42:53 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Marco Elver <elver@google.com>
Cc:     christophe.leroy@c-s.fr, linux-s390@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with generic bitops
In-Reply-To: <87a78xgu8o.fsf@dja-thinkpad.axtens.net>
References: <20190820024941.12640-1-dja@axtens.net> <877e6vutiu.fsf@dja-thinkpad.axtens.net> <878sp57z44.fsf@dja-thinkpad.axtens.net> <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com> <87a78xgu8o.fsf@dja-thinkpad.axtens.net>
Date:   Wed, 20 Nov 2019 18:42:50 +1100
Message-ID: <87y2wbf0xx.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> But the docs do seem to indicate that it's atomic (for whatever that
> means for a single read operation?), so you are right, it should live in
> instrumented-atomic.h.

Actually, on further inspection, test_bit has lived in
bitops/non-atomic.h since it was added in 4117b02132d1 ("[PATCH] bitops:
generic __{,test_and_}{set,clear,change}_bit() and test_bit()")

So to match that, the wrapper should live in instrumented-non-atomic.h
too.

If test_bit should move, that would need to be a different patch. But I
don't really know if it makes too much sense to stress about a read
operation, as opposed to a read/modify/write...

Regards,
Daniel
