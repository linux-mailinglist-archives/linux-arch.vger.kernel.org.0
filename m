Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C432D5C48
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2019 09:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfJNH0E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Oct 2019 03:26:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39606 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730143AbfJNH0D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Oct 2019 03:26:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so15026720qki.6;
        Mon, 14 Oct 2019 00:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBbQ7AJ/stV479Rt04hsWNzYBmmUeW9a8wkE7BnGvkk=;
        b=WONv5cg+5KbVy3kfAF5PHEPOKQwNrxfH1ZEFmVIR8x4GctDZW7xTyCDeUqpfYy32qu
         tp4ZMnAxA+HrO/0J67cRTRJadvQANmjv3xgF1DIfqkZmHdS4dHmuR8T07dfTRBvVzGpL
         3FakOoVSXW5bFpcaPnbnRsWwdfOdO9RDNgDcZaJuBhEzFMU4/tgjlnF1vUcgNVxIcapb
         hI/nDgD9iELJvadhoL9OeL2+2cBikNyGcPu59B8CVXLI2cxjESwuzrb193DgfSePwUDj
         n+Yu+7wdh/Zhx24/ZN6/LksI6MsL66b968LfB8hbIUDvd+AjkDUOVgntsanO1Vk5UYGv
         4Rmg==
X-Gm-Message-State: APjAAAV3ssZgSYcAZDpSMDhGDCggZfShpfsdLAADNpDNvWo+ZB3bf9hL
        VfU4slMbHpMUExNN03NgwMqRTS8cZex9Y1TomhI=
X-Google-Smtp-Source: APXvYqz2TOipLeJNoc6W1LT+iyQ+6UNf7hUSfkWUf8PsO/zIIpkBSzQ9geh2eCZiiNlHHW+TAbvlaEO4vlEOK5i7Q9M=
X-Received: by 2002:a37:a755:: with SMTP id q82mr15517562qke.394.1571037962634;
 Mon, 14 Oct 2019 00:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191013221310.30748-1-sebastian@breakpoint.cc> <20191013221310.30748-2-sebastian@breakpoint.cc>
In-Reply-To: <20191013221310.30748-2-sebastian@breakpoint.cc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 14 Oct 2019 09:25:46 +0200
Message-ID: <CAK8P3a0q+03=uNcnnHrGqHGOcAO3-mytxSmoBWLtHY+5StMNOQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] sh: Move cmpxchg-xchg.h to asm-generic
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 14, 2019 at 12:13 AM Sebastian Andrzej Siewior
<sebastian@breakpoint.cc> wrote:
>
> The header file is very generic and could be reused by other
> architectures as long as they provide __cmpxchg_u32().
>
> Move sh's cmpxchg-xchg.h to asm-generic.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Maybe change the "#ifndef __ASM_SH_CMPXCHG_XCHG_H"
to __ASM_GENERIC_*.

        Arnd
