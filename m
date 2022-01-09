Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E882348882C
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 06:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiAIF4t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 00:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiAIF4t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 00:56:49 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0101AC06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 21:56:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id ie23-20020a17090b401700b001b38a5318easo3573578pjb.2
        for <linux-arch@vger.kernel.org>; Sat, 08 Jan 2022 21:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YQ3N/XCzp9QF6bsJmUFotftFxkyrPK0SSHmU+gmOo2U=;
        b=Hkd9K/s16ohx4c4W4u2XdH2i/MBtFnq1k0awDuIq6XKx/0znSo362sRVeItIe8SXQe
         8SDGe5B2F/ll8pNhuvdknr34oh29HBSHl0LEt2X80tEVvOcaECmd4J7Iq+dnVq/mbcOO
         aY04WMDZhzcXbz2Aq8n0yRuvIGzjh+ozBiLK16ajxk7O2MY3bcrvZ09yf/Kcj6/G28g9
         vr1t/emd8cFlN4Vaq17psR9TSSq6dqHwx8UmmyovcyU4pcKacwJy9Ee2cuVtv3XjFL3f
         iDTYuR8iFHbDiuKNIgGU3DOBo61eoNAl5Fh0+C68C+6wsWfjcP7+dk+r53jLXZfPE51H
         2Ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YQ3N/XCzp9QF6bsJmUFotftFxkyrPK0SSHmU+gmOo2U=;
        b=v+9MnBDbI6cvn2msehq0NcGNzXaLCPI1PNFqWDEFwzWzcgFi7fHP9YqFrc6k4puADR
         auViUlORYDPtnAckGxlrp7aB97sler+M2oEO1OZvCSnI/6HKuJ0dM6ppVO+vb3C/Lnxk
         IqMaHa1iGajMGIkUih7oIvLHkdWqKSA8+acCK8Bo4bgrzmi/JOWDgQm55LKtM9Ei/fXJ
         zafLueW/CQbMvwPOpmTd2vDlmFPkS2CMh4hjbhV+rSIT1cQTKlyzoUiGM1RZ9YU7kAgA
         3nRWyjYIb0ANESMXqXcnXbIRGBPQm2oq5jN/JagDbqYJ0PQcqfT+Ul9/l+yA18CFtRkq
         Ekbg==
X-Gm-Message-State: AOAM531LJfHGfo6RoI7cydqUqTnnWbcNQsqtgwnS1QLL+FHdreSGjORK
        mNR4WP+1Sw07yRM7GunuPpo=
X-Google-Smtp-Source: ABdhPJxQqRGUvZt52Hw6VUiIcbS8BLGEZjDOT+nXfe7Irx0K1XSmEQvmJecm86R0hyikKzisXjw8Yg==
X-Received: by 2002:a17:903:2352:b0:14a:b4a:4629 with SMTP id c18-20020a170903235200b0014a0b4a4629mr8330722plh.45.1641707808255;
        Sat, 08 Jan 2022 21:56:48 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id on2sm4885712pjb.19.2022.01.08.21.56.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jan 2022 21:56:47 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy
 mms
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
Date:   Sat, 8 Jan 2022 21:56:45 -0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Jan 8, 2022, at 8:44 AM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> The purpose of mmgrab() and mmdrop() is to make "lazy tlb" mode safe.

Just wondering: In a world of ASID/PCID - does the =E2=80=9Clazy TLB=E2=80=
=9D really
have a worthy advantage?

Considering the fact that with PTI anyhow address spaces are switched
all the time, can=E2=80=99t we just get rid of it?

