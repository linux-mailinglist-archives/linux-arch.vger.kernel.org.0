Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450F11766DE
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 23:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgCBWZs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 17:25:48 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:47033 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgCBWZr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 17:25:47 -0500
Received: by mail-pf1-f177.google.com with SMTP id o24so383454pfp.13
        for <linux-arch@vger.kernel.org>; Mon, 02 Mar 2020 14:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6efxeA5g+rwuMvQr8ytRhTu98WaYVw12E5bJfbsJYZ4=;
        b=CtlFLiEgdgOJIvHde7LjiTVdMr7XEM5pCx2TL4QzVEgZNJ26I/KZvhJiBpfLhzBr4H
         UqDukDl1036Z2VoAjaYootIOlpSy5Ab5+4z+fJ6+/6G2q/7IDtBSkXgSNhp5DMc1yVVn
         ndR8/cg135lWM5cabo5z+wg9hmQJcQAalzllyhxCMwuLhkQdp5Ry5oE+ri7hoo7d/ICx
         dVleXyhu2b65FbQg9s0PnRuIMtIjI5QW/mIRhOoMIEWS+aeoSB9R79ieB0FhUzpqr7qz
         qy9FEMri79p7n6p+hRr6rMTU+Le0Go7qVbs2nbVEcB9fOY+bwem9CLw2CKfdp33zM+UP
         pk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6efxeA5g+rwuMvQr8ytRhTu98WaYVw12E5bJfbsJYZ4=;
        b=WE2XrZufW/Oc7RPdLCYrs4udpweGZ4Kx8Df3p+uFaN7h69QseTxY/Y2b8P3A9lUmkE
         B6S3rm7PqKCyWc6j8yWzQVyWAF1Gx0jvjXsp3WCoH/Ib57ngVzsdtbp850RXpVgtTEq/
         L+/t6Ss66FI515gKYG42ZTzPwGAJHNS2Upps76Gjw597jJyRYGgjhrn/LmzHaYs4mcGw
         ECB0AD43k2LWV7X6LZ4FnHROqzhCk9OtdCslVgBIiHD7vb6EfbHs/j7C6FpjykuX8miH
         z9OJVSemuG5dFI9Hpbxmy5sOr+vOG95JHh1h5FheErf1iuE1ihPznNlp3AXHx3RK2ydO
         oMQg==
X-Gm-Message-State: ANhLgQ0mmEPB6p9Hl627BiLxgTbNClmmITYKtXg4n9e080A/hXQG9fUp
        0D0OAp1nqtR7Vn5f35VpOhkZSqhhC1gitKhmJ4VmmA==
X-Google-Smtp-Source: ADFU+vuIlSusFAlLcQ/Qbkm1zRK4hcRHHhfsZtG+4e7FhIOMG8G0a1QMZ5iwpVJnxKXi+rUWnFzSQvPpdZO9ZY2n5s4=
X-Received: by 2002:a63:dd06:: with SMTP id t6mr987590pgg.384.1583187946657;
 Mon, 02 Mar 2020 14:25:46 -0800 (PST)
MIME-Version: 1.0
References: <fb0fcf4ffddaabc7eae82e25d7ec5ea9c37eb2ae.1573179553.git.thehajime@gmail.com>
 <20200123193315.132434-1-brendanhiggins@google.com> <20200302195116.GF11244@42.do-not-panic.com>
In-Reply-To: <20200302195116.GF11244@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Mar 2020 14:25:35 -0800
Message-ID: <CAFd5g44+PD9FM6Vhy2uFAkSvgsOdxjy2gcP6duBzuhJGJaddgg@mail.gmail.com>
Subject: Re: [RFC v2 21/37] lkl tools: "boot" test
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Hajime Tazaki <thehajime@gmail.com>,
        Octavian Purdila <tavi.purdila@gmail.com>,
        David Gow <davidgow@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org, Patrick Collins <pscollins@google.com>,
        Conrad Meyer <cem@freebsd.org>,
        Motomu Utsumi <motomuman@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        Petros Angelatos <petrosagg@gmail.com>,
        Yuan Liu <liuyuan@google.com>,
        Thomas Liebetraut <thomas@tommie-lie.de>,
        Mark Stillwell <mark@stillwell.me>,
        David Disseldorp <ddiss@suse.de>,
        linux-kernel-library@freelists.org,
        Luca Dariz <luca.dariz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 2, 2020 at 11:51 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Jan 23, 2020 at 11:33:15AM -0800, Brendan Higgins wrote:
> > Luis,
> >
> > Does this kind of match what you were thinking with the syscall testing?
>
> Without looking too deeply into the code, it seems to be the case.
> Are you going to expose / port kunit to tools/ to allow usersapace
> to run kunit tests?

Yes, I am thinking about this as a distinct possibility. I think it
only really makes sense in the context of syscall testing, probably
via LKL (assuming this works), but for general end-to-end testing, I
think kselftest has that area covered and users would be better served
by just integrating KUnit with kselftest.

> > In any case, I am excited about this. Please keep me posted in the
> > future!
>
> Yes please Cc me too.
>
>   Luis
