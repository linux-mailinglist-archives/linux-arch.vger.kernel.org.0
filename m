Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF0C3D2B1D
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 19:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhGVQqu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 12:46:50 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:49673 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhGVQqu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jul 2021 12:46:50 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MlfCm-1lOzzF2Z0c-00ikmO; Thu, 22 Jul 2021 19:27:23 +0200
Received: by mail-wm1-f48.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so51391wmb.5;
        Thu, 22 Jul 2021 10:27:23 -0700 (PDT)
X-Gm-Message-State: AOAM531bVfVPXRB58faUTTMBdF4kMmTdfIIRb7h1gxRKWzxLwMAReQ1C
        lA1gr8GwZTYevtigH6KuzS/r9utjbafqsFYR+Z8=
X-Google-Smtp-Source: ABdhPJxFV5o/PNV/LrTbie+vztRCHh/qyZxsvfqFMbgLHcWOP6YcXa9IKh3rGm7tsGrxhysvLjFSXHJXu30On0LyJto=
X-Received: by 2002:a7b:c385:: with SMTP id s5mr625565wmj.43.1626974843327;
 Thu, 22 Jul 2021 10:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200918124624.1469673-1-arnd@arndb.de> <20200919052715.GF30063@infradead.org>
 <CAK8P3a1LM8SXbzcVv1B05fdmxBZ-PA+P4m4oP1Dgc4JmR2CGMw@mail.gmail.com> <YOKgQCTB6Rd+jIom@infradead.org>
In-Reply-To: <YOKgQCTB6Rd+jIom@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 22 Jul 2021 19:27:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a28S83ncc=EyqJZpeNh7MAh9g7uvc4j82LHsx-22O8Mcw@mail.gmail.com>
Message-ID: <CAK8P3a28S83ncc=EyqJZpeNh7MAh9g7uvc4j82LHsx-22O8Mcw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] ARM: remove set_fs callers and implementation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EqqmyvAyrr6R7wKaCx2tdeRSEKaSYl+MIxN7QUz/GpjYyc4QoAy
 8tkdcFQBYrAoVSwdKk6dyZ0jsYFKH66ENOCCL2KXtSrEm3P1w4oyYhQXiUVVRtRyAPa/6Cz
 A6gncjNgJ9w2yFT6UPN01n3iidPoDIObcvRzvjHyoah8EAsyg/xp09JCL3q6nWfxwL3WSPW
 p+B0d80D2fxhuR2WdlnoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LIkmzQs0a0M=:ug0JIU+2EGgCwoCvmCxJWS
 H6RFboEMxsyQzUMkKP2f1DOMU18eRNcsoo+x9cqytu3kfYeHZqu/39PTMtW8CzrWRmXOOVKjq
 wBOMnZntFhJgJFimh8u4WE14JwBDq/WNsCZmQKIK3QYFcAtWcyXXC+Of9zhMin0KX+wsYVl0c
 DtNW2eK7uVklyy9ZnnXCEjx0i/XMsMnrAas2iK6yzHgko08yeJHy+RPCnsVhMvCsBog6NCA7E
 dfpWQ61ykrw/q7PS3lQuA/ZK8s6mgFGN+A+tYw6Kqu4QWT+TAp8SteUJh6iwdSfXa0xEo9oMq
 F8eWKRg7xiowCa1kOFQN+8bNH4RH1hOW3ckLy2GxivEMFYnhcaa1G6ziYDxs91zkQcuRT3E0s
 I1ZAaUa6uztLpXxg6G3dWYsnRQrlYTKywRtXJfelYtVOYw/s1WrjyXyCkOLq7vNFkpaQDOnC1
 XABO+UA2a/XvzUJX8ME+bjYQM86xcSjKWnBIM1CWBjgxhdTorD6M1sT1nL5ev3wwrLkJZUdmi
 zC6uGeSb56tCnb0Qkty3jqzjb4oUg4dI7QcvNWs/DceGosGjVujFPVTGF9oYk5Znylh2AFMhK
 pIrRlVxXF/ixsjOWBS46p3diYTvD0V1IWK5vKmuF1n4kLWklDe5ulygslHW2anX0PWZzS6lTJ
 /5ibogpMrLJ65xbMLq+JOKwz0r1Y3db3v2jkcdGLB8PDGN83AIrTwLmn5lM06LUFwsIW5Cf7V
 hANrF9dYopNjslluLS4JHCzT1XL/d3wsNiO5a2YCXrhAzVkITH+SV/cJNRGLkTf7JWZfWJ4jA
 +0zN/wGlgxWDNJVeZyCUuuZEUSjc3R7CiwGpD+T1GJ1lj6EoI+8pCQnTjv+K1pWX24GRnKE
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 5, 2021 at 8:01 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Just a ping if we're making some progress on this.  The m68knommu
> set_fs implementation is actively misleading, which lead to a problem
> this merge window so I'd really like to see this set merged.
>
> Also your improvements to the copy_from_kernel_nofaul loop would be

I've rebased the series now, and rearranged a little in order to address
Russell's concerns. I still have one regression that I need to fix before
sending the new version.

        Arnd
