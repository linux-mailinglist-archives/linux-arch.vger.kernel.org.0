Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A29A2166CE
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jul 2020 08:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgGGGvO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jul 2020 02:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgGGGvN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2020 02:51:13 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CD7C061755;
        Mon,  6 Jul 2020 23:51:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B1Cl33l59z9sDX;
        Tue,  7 Jul 2020 16:51:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1594104671;
        bh=oOXgPAgmimC+5OE9S4VzNRBLBVUe1Z5iRWSG3SmsNnU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=orQ7RC9s4UsZ5RZwELngkGP6M3YB0Jzi4XZFS5CBwtWWfBtjZ9dcUYXpNqEirOwdp
         dAMeUjR7JdOTAiGz9fr1Vs6i06qhy53bvEEZ7mIJc9QlnFSlR9q0R6z90spkoAGcMb
         qhH3IjcYuJEwPexfZnCSt7DXJFeSQ/jjdsFuIuDjnKwJZwAWERgpPbq1GaJ1ClZ+3u
         ioq9wspTfzA5OnDHoB1+oo0Y/zdpqx/O5SsJ88Rel32NI0kw74XYyGNeTHPE9mgYHZ
         IzttUCk1UeHIhsfwql9id9OC71X+BQA5A86fPuKFkRl16yT7cBlrGO3z8b3Vi+VnNw
         sZsIqfkFBwpXg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@ozlabs.org
Cc:     linux-arch@vger.kernel.org, hughd@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] selftests/powerpc: Update the stack expansion test
In-Reply-To: <8f6c5175-32ce-34a2-873d-b5fb3a5d7c4c@csgroup.eu>
References: <20200703141327.1732550-1-mpe@ellerman.id.au> <20200703141327.1732550-3-mpe@ellerman.id.au> <8f6c5175-32ce-34a2-873d-b5fb3a5d7c4c@csgroup.eu>
Date:   Tue, 07 Jul 2020 16:53:23 +1000
Message-ID: <87eepn4xzw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 03/07/2020 =C3=A0 16:13, Michael Ellerman a =C3=A9crit=C2=A0:
>> Update the stack expansion load/store test to take into account the
>> new allowance of 4096 bytes below the stack pointer.
>
> [I didn't receive patch 2, don't know why, hence commenting patch 2 here.]
>
> Shouldn't patch 2 carry a fixes tag and be Cced to stable for=20
> application to previous kernel releases ?

Yes it should.

cheers
