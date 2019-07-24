Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D1472C96
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2019 12:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfGXKva (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jul 2019 06:51:30 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38428 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGXKv3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jul 2019 06:51:29 -0400
Received: by mail-vs1-f67.google.com with SMTP id k9so31015845vso.5;
        Wed, 24 Jul 2019 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Bu26HmT5VmoCYCpR6iplFNSjeK1kwtiFeo7LAU3Mayw=;
        b=MFbkcLVudKrK8MwQA8fjNBn1lWw4QcFG8T9RFOftrdWt4zO6yMFlK2RmGLIMCUl1cJ
         JINHHcp1NNVqXhqMZ809GRmgmYLHJRBkzHl1qurCLkk99HUcXaUOZGHuBhiXLP+zSnWK
         aUfWCYh6Q7JI1MXd8KjbzXA2vBHEmSeIsD07oFfGF4ACzM1e0I25WX4krgpwCI7S9brj
         +zKJ/zebAg0XG9gP+dg7FUVaTjQ5Mm4TgfaDBGvQkngDAJvWEjh6fhyajePaAlM9WDvz
         9s+/rr290F+KGX1nPQ4kyw4VhABzeSf7wSIEWsGQ8Ky/AdXf6RLXy98dIMMs+XQc9bNz
         cr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Bu26HmT5VmoCYCpR6iplFNSjeK1kwtiFeo7LAU3Mayw=;
        b=mLqJZG5GkMKrrIcQ+2Lf3onSC+2Sa6MFoJn22OQ0vKU44TUgRNHKY/Kg0Cn+CINZ4z
         zbamn+hnBBIG2NvTlmZQcIjwkOULxP913XIN3f80O/9Isih3DtJUOMg2W+W47SBgnpRX
         FrUeeFSC7pGqOdyAznwBGkJTjlJjHHoPBe8WXKRpbwDv7FVdkhsPZovE6mno1O6f/QMN
         fNnw4CVJzGVz9XAxIB2Ncmo00AHiPRYZZjV1o17rzT7eQqLGJgbdHoTEmmtBdDjowqHm
         rdmvW1UNPawaBFfq72QSLgZBmFpaNEDxBMoTA0tr5BmrVT8FhJGbKfDv1C3RpmYeT34Z
         AJ2g==
X-Gm-Message-State: APjAAAUAThmWmDRBR5jO4ZSFKzbF4Ln8LZ1PmftxBGdTSLsXICqnahcM
        iXNYBR2bt7JUJ7MOLiKEH/8YFd3rKuyg0pVFMvyfCnM=
X-Google-Smtp-Source: APXvYqyqekrxcJ/rVOiJBXglvFRza9GYrX7G4hCqq7tpnrJVcqTLJJLeCkD91x+c52mCFOnIriGvbc1xBsd70sVEWNk=
X-Received: by 2002:a67:d46:: with SMTP id 67mr52122041vsn.181.1563965488469;
 Wed, 24 Jul 2019 03:51:28 -0700 (PDT)
MIME-Version: 1.0
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 24 Jul 2019 11:51:17 +0100
Message-ID: <CALjTZvbrS3dGrTrMMkGRkk=hRL38rrGiYTZ4REX9rJ0T+wcGoQ@mail.gmail.com>
Subject: [BUG] Linux 5.3-rc1: timer problem on x86-64 (Pentium D)
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, everyone,

I don't know if this has been reported before, but from a cursory
search it doesn't seem to be the case.
I have a x86-64 Pentium (4) D machine which always worked perfectly
with Linux 5.2 using the TSC as the clock source. With Linux 5.3-rc1 I
can't, for the life of me, boot it with anything other than
clocksource=jiffies, it completely hangs without even a backtrace.
At the moment I'm at work and, for obvious reasons, I'm not able to
bisect this remotely. In any case, if anyone has any idea about the
cause, I'll be glad to help debugging and testing any patches.

Thanks in advance,
Rui
