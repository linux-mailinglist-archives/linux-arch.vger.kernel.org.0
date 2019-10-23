Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034F5E2519
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 23:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406307AbfJWVUN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 17:20:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42454 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406299AbfJWVUN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 17:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571865612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnnKmO1fJuUv7LZ9F4cO56t6iJItAo2+NBtvnDOUSk0=;
        b=icUtm/zsqsQBuem4ILpFoyrPtGK7NE+S5u15YytSuvTxDY8K4H2KjYcgit5zYCu7ocxZLJ
        6O4B5oFGt0zQVU/8RQbkC2R1cxmFInI4cGaI459HgLcWwyHhAvuMmF6pvJkYqYb/1f7Lt+
        y5s24ujY2SRlXy5yoGAu3Kn5S//7Kiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-oYnTQt40O02pytVgayjTUw-1; Wed, 23 Oct 2019 17:20:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A6B7800D49;
        Wed, 23 Oct 2019 21:20:06 +0000 (UTC)
Received: from treble (ovpn-121-225.rdu2.redhat.com [10.10.121.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44A4E194B6;
        Wed, 23 Oct 2019 21:20:03 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:20:01 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 00/17] entry: Provide generic implementation for host
 and guest entry/exit work
Message-ID: <20191023212001.hsx4phmzkq3cywva@treble>
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20191023122705.198339581@linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: oYnTQt40O02pytVgayjTUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 23, 2019 at 02:27:05PM +0200, Thomas Gleixner wrote:
> The series is also available from git:
>=20
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP/core.ent=
ry

Actually

     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.core/ent=
ry

:-)

--=20
Josh

