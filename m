Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BC0250FEA
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 05:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgHYDW7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 23:22:59 -0400
Received: from mail.loongson.cn ([114.242.206.163]:34532 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728554AbgHYDW7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 23:22:59 -0400
Received: from localhost.localdomain (unknown [222.209.10.89])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxauT3g0RfXqUNAA--.17408S2;
        Tue, 25 Aug 2020 11:22:38 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     tsbogend@alpha.franken.de
Cc:     akpm@linux-foundation.org, jiaxun.yang@flygoat.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        maobibo@loongson.cn, paulburton@kernel.org
Subject: Re: [PATCH v2 1/2] MIPS: Set page access bit with pgprot on
Date:   Tue, 25 Aug 2020 11:20:38 +0800
Message-Id: <20200825032039.21413-1-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200726083206.GE5032@alpha.franken.de>
References: <20200726083206.GE5032@alpha.franken.de>
X-CM-TRANSID: AQAAf9AxauT3g0RfXqUNAA--.17408S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5t7k0a2IF6F4UM7kC6x804xWl14x267AK
        xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
        6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
        1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvE
        ncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I
        8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8rcTPUUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

adjust the code and add support non-rixi 


