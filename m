Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B6F2A4087
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 10:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgKCJqN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 04:46:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgKCJqN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Nov 2020 04:46:13 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C042244C;
        Tue,  3 Nov 2020 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604396772;
        bh=XYLjUb/wt/Qh/YwIScTOgSYD1ESCUFNNtg4rDkz2sZI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NfOl8d72y9ApjD47h6GqNUWNwdCatoOIwZ1fJLqqbGdH0qE8lOPsHWz9sDg5F9xO8
         VJ2a/P2mI1mYRYL8kEuvW8lIKRYtXh2HEnjFPN5s83Hj5qCIAzNz2wjxLij0NXolCa
         nsUiN6PAkqr73M2gfIlPMVC788X5Tjn4AKF/+QLk=
Received: by mail-wr1-f49.google.com with SMTP id n15so17801749wrq.2;
        Tue, 03 Nov 2020 01:46:12 -0800 (PST)
X-Gm-Message-State: AOAM532awfI8C4F5N++R0AuWJyEXUJID6t82+g/HM2cC3M5WBGjeZAeO
        JV9BXGEL327r7Uy6QJ6vSrM5F0pjz8oNg9SnQlg=
X-Google-Smtp-Source: ABdhPJz5/pmJbk1avpEhMdak9TfFmMuhdl1BuBXo90BhZ5viZ969NVVvRVPq/4iJo0zCBjuw7Ekvw0+pHt+H1AfrHvc=
X-Received: by 2002:adf:eb4f:: with SMTP id u15mr18835987wrn.165.1604396770994;
 Tue, 03 Nov 2020 01:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20201102123151.2860165-1-arnd@kernel.org> <20201102123151.2860165-5-arnd@kernel.org>
 <20201103083703.GD9092@infradead.org>
In-Reply-To: <20201103083703.GD9092@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 3 Nov 2020 10:45:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2m_VYiTY7Rg+3kfohPc2W=jHLh7dF4aVffSpwMa7C=4Q@mail.gmail.com>
Message-ID: <CAK8P3a2m_VYiTY7Rg+3kfohPc2W=jHLh7dF4aVffSpwMa7C=4Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] compat: remove some compat entry points
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 3, 2020 at 9:38 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Nov 02, 2020 at 01:31:51PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > These are all handled correctly when calling the native
> > system call entry point, so remove the special cases.
>
> Ok, this is where you do it.  I think this belongs into the main
> patches.

I had it there originally, I guess I should have left it there ;-)

When I changed it, I was considering to do the same for additional
syscalls that have very small differences now (timer_create,
rt_sigqueueinfo, rt_sigpending, recvmsg, sendmsg) and use
in_compat_syscall() there, but then I decided against that.

In the end, I did like the split, as I found the smaller three
patches that contain the real change easier to review, and
it turns the larger patch at the end into a more obvious
transformation.

      Arnd
