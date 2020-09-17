Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D05826E5CD
	for <lists+linux-arch@lfdr.de>; Thu, 17 Sep 2020 21:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgIQT4c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Sep 2020 15:56:32 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47891 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgIQOpd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Sep 2020 10:45:33 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 10:44:08 EDT
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Bsfc51bKlz1qrfr;
        Thu, 17 Sep 2020 16:34:13 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Bsfc50dRNz1qxpD;
        Thu, 17 Sep 2020 16:34:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 5BBP84tpYrRa; Thu, 17 Sep 2020 16:34:12 +0200 (CEST)
X-Auth-Info: 9jeFQNW3jEEEH5nEGLwfVfPMZp09Oa4fJ4yvtcjDHLxUxZpFdLTFXHuxHVOi8s+j
Received: from igel.home (ppp-46-244-188-79.dynamic.mnet-online.de [46.244.188.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 17 Sep 2020 16:34:11 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 0E03B2C2894; Thu, 17 Sep 2020 16:34:11 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch <linux-arch@vger.kernel.org>,
        Tony Ambardar <tony.ambardar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Rosen Penev <rosenp@gmail.com>, bpf <bpf@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] powerpc: fix EDEADLOCK redefinition error in
 uapi/asm/errno.h
References: <20200916074214.995128-1-Tony.Ambardar@gmail.com>
        <20200917000757.1232850-1-Tony.Ambardar@gmail.com>
        <87363gpqhz.fsf@mpe.ellerman.id.au>
        <CAK8P3a3FVoDzNb1TOA6cRQDdEc+st7KkBL70t0FeStEziQG4+A__37056.5000850306$1600351707$gmane$org@mail.gmail.com>
X-Yow:  Yow!  Am I cleansed yet?!
Date:   Thu, 17 Sep 2020 16:34:11 +0200
In-Reply-To: <CAK8P3a3FVoDzNb1TOA6cRQDdEc+st7KkBL70t0FeStEziQG4+A__37056.5000850306$1600351707$gmane$org@mail.gmail.com>
        (Arnd Bergmann's message of "Thu, 17 Sep 2020 16:01:27 +0200")
Message-ID: <87h7rw321o.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sep 17 2020, Arnd Bergmann wrote:

> The errno man page says they are supposed to be synonyms,
> and glibc defines it that way, while musl uses the numbers
> from the kernel.

glibc also uses whatever the kernel defines.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
