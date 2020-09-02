Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B3725AA71
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIBLnr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 07:43:47 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33321 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIBLno (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Sep 2020 07:43:44 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M4JeB-1kDA3o2CrB-000MTH; Wed, 02 Sep 2020 13:43:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic/sembuf: Update architecture related information in comment
Date:   Wed,  2 Sep 2020 13:43:27 +0200
Message-Id: <159904687265.1152288.2415881924142426407.b4-ty@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <64efe033394b6f0dfef043a63fd8897a81ba6d16.1589970173.git.viresh.kumar@linaro.org>
References: <64efe033394b6f0dfef043a63fd8897a81ba6d16.1589970173.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FZeoeRyAbMueqVlNawJoUXu768pTJnwXm5Mv/M+hNLPd/qnc9VV
 a6WqPPypF75yC+dzGf5eVOnIgmetXUSJcz+EU0PEHvxMvP1RPBXTq39Xc1V3XW0QqCGADyX
 a/VC8JfSEs9lgAsiT71zkyO5Yr+9D8FGHJcw/7w5WoJASF3eC612QtbybW6m6zkr1XBj35F
 9gJDfbuQAVFaAUCZ/UR1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pPalDEHl1nA=:5pDtjDyZcFqV6WGQK93Vuu
 bNiNSpyRFLqqS5eG06gNwVfTmb6qmqd7ae9VGFTz8rva8e9RCc2bvaOpKD+xeQxNNRAlQIVwp
 pXMDViVvo8tvKfizX6t4uXQWAe2gWoRVSZ35xTYc5Za5KwZoB5Udotz92c32jnEdIx0WB0R0u
 UROVj0J64V7NfW8SGjjDdxAlS3KYBAXCJfPjBZXjfOfMcwU7gtWZVo01vIAWi/Yg89LUPWgn0
 Dp0HC4jTB9vVxpcrz2d9/V4l8Sr+xIp/J3sfP52AvK5eTqOvfsjOrx5AMWTOcQwab2sDgh1Gg
 Hk5Q19W2E8ZoAYjsLU3rwsFKmjfwCOQ9z6Yh64ZJ+JNrOFN6PcRAlu7DQ5wLAqueMD9uIuEx5
 13sL+3fMyLvgPR3/oQq4NSKTZV7mE178jDPJliUSw13MTGu8Fy7U7MPXt9bd/FQyMObOFd7bi
 59KdCBVddT/Hb45Gx04qZ9QcuanVSlY8GgHuImgfiA4Ybs5xzWnKrVZqAuvyt5N4iCjwo5EvK
 Y05MVFCuDXEG8djKLQMg4apitcKPso98zTywuLD1AQjFNTVN9vHOzlND795W8pQ3haUEPEXRA
 6Wp3A8478cIbDuLrznGhtpEgHNWjZdgpac1MlPwR6CkgrLG4Iqz24E0rO+mhopPXjpYaSwLsA
 W6x+CJi7MAEfqggMO+h0mmwp+fZEvAWXSBHTeGCtyYRWSdkceAYujhBTBRIxRD72TzUw8wHhk
 2lZrGGFoPPoLxOj0/NyALU+bG8Z3yGKqDspPF02CBFV3iB0JQ/ZJEKQtLp8ImvCFe1klyMhB7
 ZEBFP1D6q5kFB+5r8JJoOgXX3QQ0uA1BpknJsGtZmRsMJd3s5L8prxb+DJepFYbegCVEBlM
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 20 May 2020 15:53:08 +0530, Viresh Kumar wrote:
> The structure came originally from x86_32 but is used by most of the
> architectures now. Update the comment which says it is for x86 only.

Applied to asm-generic, thanks!

[1/1] asm-generic/sembuf: Update architecture related information in comment
      (no commit info)

	Arnd
