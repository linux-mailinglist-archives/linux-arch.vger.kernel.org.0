Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1756B232
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 01:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfGPXHT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 19:07:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44814 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGPXHS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 19:07:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so10159901pgl.11;
        Tue, 16 Jul 2019 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=YF5uWvW0lLwROvyPf53Wapwm3mzwcjBd4TlGJz7uSQc=;
        b=Rgtqp4IDVXbKUFwCa8iBTAmLZ3icHtHxZ0xxcPrO34ppbQnUbbi4wGbJ8Y3Hs1LJaj
         IrXL2sIU6q0QMst9f5/CtKr1eXCd2I5pUylvKHhErt5+buRBS/8nxqklBlIbKIqQzKXp
         KZUbwdumcqMBoO47sqDNZ+7zfDRq4/0in70LDstQEsC8lof1FeQ6BHqXDzCRAjcdl/re
         ups9T2L11lLTRQfrQj7Iglktz7n41R5ywDI3qu3fRS80qVNjJhV5Dam8hKUk46lU5OIt
         h7rFnLUcqNhbjl8uAJwzmaeEJjBPl71yU8h1Ualjnp+D/5tWP6WS7v0Qh0wqDV0h+Ryi
         8SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=YF5uWvW0lLwROvyPf53Wapwm3mzwcjBd4TlGJz7uSQc=;
        b=DR47nMHqwoF9ZXKTD4ta30+cax5vnk0giKBPsJ4EbyURYcTYVHxPCKy4uJhDoRuV4O
         ohtQqq7ZEnQ3DJrREs9KCzsrbVivbiFD1RekOafCR3kWtEpdlDIIW77Mp3yWnICBvrde
         1LbFsv8zuxyDcuXONrJzq9y9rNTVHMtLCi1Hje7ppNAJUq9vHyMuhLG3eLn0GM1BWqJe
         cOnHGiKSDkKXiX4XLsSf2cgZ3auCNXtaOOFLqHJOGTq3jzTWU1hS19uWq6FDEh7JE55Y
         8ZgySFiWEB+4Mug6a3V/sUcMxeiE12q5QyzHHnT8h4tzpXrixjcNq5ClLCVuGPsAIFju
         +XUw==
X-Gm-Message-State: APjAAAWZZMZcGSeZSKsfeoBzW9StZoj+VoBq8lquKQX8NWrqLACLWqtD
        fTRzB8y4ri0BQl1G++4Bbnk=
X-Google-Smtp-Source: APXvYqxbSot0tXbWZTT8zOiFvyxu3Z1k54Da4RuRhE16yCPnDE+TL5XF8kjTOt8H3YqXHJTMsqtj+g==
X-Received: by 2002:a17:90a:3086:: with SMTP id h6mr40520027pjb.14.1563318437747;
        Tue, 16 Jul 2019 16:07:17 -0700 (PDT)
Received: from localhost ([203.220.8.141])
        by smtp.gmail.com with ESMTPSA id s12sm19683707pgr.79.2019.07.16.16.07.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 16:07:16 -0700 (PDT)
Date:   Wed, 17 Jul 2019 09:07:09 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/5] Add NUMA-awareness to qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, bp@alien8.de,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        guohanjun@huawei.com, hpa@zytor.com, jglauber@marvell.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
        rahul.x.yadav@oracle.com, steven.sistare@oracle.com,
        tglx@linutronix.de, will.deacon@arm.com, x86@kernel.org
References: <20190715192536.104548-1-alex.kogan@oracle.com>
        <1563277166.m9swqogbqb.astroid@bobo.none>
        <7D29555E-8F72-4EDD-8A87-B1A59C3945A6@oracle.com>
In-Reply-To: <7D29555E-8F72-4EDD-8A87-B1A59C3945A6@oracle.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563317552.qsi08y8lyr.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Alex Kogan's on July 17, 2019 12:45 am:
>=20
>> On Jul 16, 2019, at 7:47 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>=20
>> Alex Kogan's on July 16, 2019 5:25 am:
>>> Our evaluation shows that CNA also improves performance of user=20
>>> applications that have hot pthread mutexes. Those mutexes are=20
>>> blocking, and waiting threads park and unpark via the futex=20
>>> mechanism in the kernel. Given that kernel futex chains, which
>>> are hashed by the mutex address, are each protected by a=20
>>> chain-specific spin lock, the contention on a user-mode mutex=20
>>> translates into contention on a kernel level spinlock.=20
>>=20
>> What applications are those, what performance numbers? Arguably that's
>> much more interesting than microbenchmarks (which are mainly useful to
>> help ensure the fast paths are not impacted IMO).
>=20
> Those are applications that use locks in which waiting threads can park (=
block),
> e.g., pthread mutexes. Under (user-level) contention, the park-unpark mec=
hanism
> in the kernel creates contention on (kernel) spin locks protecting futex =
chains.
> As an example, we experimented with LevelDB (key-value store), and includ=
ed
> performance numbers in the patch. Or you are looking for something else?

Oh, no that's good. I confused myself thinking that was another will it
scale benchmark. The speedup becomes significant on readrandom, I wonder
if of it might be that you're gating which threads get to complete the=20
futex operation and so the effect is amplified beyond just the critical
section of the spin lock?

Am I reading the table correctly, this test gets about 2.1x speedup when
scaling from 1 to 142 threads in the patch-CNA case?

Thanks,
Nick
=
