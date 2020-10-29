Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D192629F838
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 23:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgJ2WdI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Oct 2020 18:33:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36534 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgJ2Wci (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Oct 2020 18:32:38 -0400
Message-Id: <20201029221806.189523375@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604010728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dHsj3bB6txbW51auQ1NY6Tbn9YUEP9hPQj+cerV4cH0=;
        b=QSHJIt7LvlxNN9hJ0pBq2tvQAj6s9PRKwf9DDs+9wLl0TB3D07XB2aNc/P+jBNvq3OKdlB
        9uImGW8KQrL2/v2DDWGmYr3ItyplTubI+62xRgbsyi4IeFKyTQeBZLSpOp/k//RoMYNU0D
        MRXq2PcsrvKw8tKj6JtpzI7I7c+m0/l1rgAB1Q7e0HTSfRHwiF/OYPDVhjJi/t5CuooKwL
        72rzQkellKlgnCIrCAJFk+1lKoYhevy2jnE7fElUwMoYj2u61NhwHpz39yR1AKfSxC9hiI
        tHhi3pMD0MqXztTmwu1jN5JS5hiXfWpnm7xNyzYqMOICUggRy8lWVYhFp7D5AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604010728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dHsj3bB6txbW51auQ1NY6Tbn9YUEP9hPQj+cerV4cH0=;
        b=bG4zbqkg1p92+Z0M4jQM3XbBv8SsS1VZa551XHoVYcBtO5FLMANBcd4TnLvpnuGvnhoALG
        sOxX2o7Ksc9Qt8DQ==
Date:   Thu, 29 Oct 2020 23:18:06 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Rm9sbG93aW5nIHVwIHRvIHRoZSBkaXNjdXNzaW9uIGluOgoKICBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjAwOTE0MjA0MjA5LjI1NjI2NjA5M0BsaW51dHJvbml4LmRlCgphbmQgdGhlIGlu
aXRpYWwgdmVyc2lvbiBvZiB0aGlzOgoKICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjAw
OTE5MDkxNzUxLjAxMTExNjY0OUBsaW51dHJvbml4LmRlCgp0aGlzIHNlcmllcyBwcm92aWRlcyBh
IHByZWVtcHRpYmxlIHZhcmlhbnQgb2Yga21hcF9hdG9taWMgJiByZWxhdGVkCmludGVyZmFjZXMu
CgpOb3cgdGhhdCB0aGUgc2NoZWR1bGVyIGZvbGtzIGhhdmUgd3JhcHBlZCB0aGVpciBoZWFkcyBh
cm91bmQgdGhlIG1pZ3JhdGlvbgpkaXNhYmxlIHNjaGVkdWxlciB3b2VzLCB0aGVyZSBpcyBub3Qg
YSByZWFsIHJlYXNvbiBhbnltb3JlIHRvIGNvbmZpbmUKbWlncmF0aW9uIGRpc2FibGluZyB0byBS
VC4KCkFzIGV4cHJlc3NlZCBpbiB0aGUgZWFybGllciBkaXNjdXNzaW9uIGJ5IGdyYXBoaWNzIGFu
ZCBjcnlwdG8gZm9sa3MsIHRoZXJlCmlzIGludGVyZXN0IHRvIGdldCByaWQgb2YgdGhlaXIga21h
cF9hdG9taWMqIHVzYWdlIGJlY2F1c2UgdGhleSBuZWVkIG9ubHkgYQp0ZW1wb3Jhcnkgc3RhYmxl
IG1hcCBhbmQgbm90IGFsbCB0aGUgYmVsbHMgYW5kIHdoaXN0ZWxzIG9mIGttYXBfYXRvbWljKi4K
ClRoaXMgc2VyaWVzIHByb3ZpZGVzIGttYXBfbG9jYWwuKiBpb21hcF9sb2NhbCB2YXJpYW50cyB3
aGljaCBvbmx5IGRpc2FibGUKbWlncmF0aW9uIHRvIGtlZXAgdGhlIHZpcnR1YWwgbWFwcGluZyBh
ZGRyZXNzIHN0YWJsZSBhY2Nyb3NzIHByZWVtcHRpb24sCmJ1dCBkbyBuZWl0aGVyIGRpc2FibGUg
cGFnZWZhdWx0cyBub3IgcHJlZW1wdGlvbi4gVGhlIG5ldyBmdW5jdGlvbnMgY2FuIGJlCnVzZWQg
aW4gYW55IGNvbnRleHQsIGJ1dCBpZiB1c2VkIGluIGF0b21pYyBjb250ZXh0IHRoZSBjYWxsZXIg
aGFzIHRvIHRha2UKY2FyZSBvZiBldmVudHVhbGx5IGRpc2FibGluZyBwYWdlZmF1bHRzLgoKVGhp
cyBpcyBhY2hpZXZlZCBieToKCiAtIFJlbW92aW5nIHRoZSBSVCBkZXBlbmRlbmN5IGZyb20gbWln
cmF0ZV9kaXNhYmxlL2VuYWJsZSgpCgogLSBDb25zb2xpZGF0aW5nIGFsbCBrbWFwIGF0b21pYyBp
bXBsZW1lbnRhdGlvbnMgaW4gZ2VuZXJpYyBjb2RlCgogLSBTd2l0Y2hpbmcgZnJvbSBwZXIgQ1BV
IHN0b3JhZ2Ugb2YgdGhlIGttYXAgaW5kZXggdG8gYSBwZXIgdGFzayBzdG9yYWdlCgogLSBBZGRp
bmcgYSBwdGV2YWwgYXJyYXkgdG8gdGhlIHBlciB0YXNrIHN0b3JhZ2Ugd2hpY2ggY29udGFpbnMg
dGhlIHB0ZXZhbHMKICAgb2YgdGhlIGN1cnJlbnRseSBhY3RpdmUgdGVtcG9yYXJ5IGttYXBzCgog
LSBBZGRpbmcgY29udGV4dCBzd2l0Y2ggY29kZSB3aGljaCBjaGVja3Mgd2hldGhlciB0aGUgb3V0
Z29pbmcgb3IgdGhlCiAgIGluY29taW5nIHRhc2sgaGFzIGFjdGl2ZSB0ZW1wb3Jhcnkga21hcHMu
IElmIHNvLCB0aGUgb3V0Z29pbmcgdGFzaydzCiAgIGttYXBzIGFyZSByZW1vdmVkIGFuZCB0aGUg
aW5jb21pbmcgdGFzaydzIGttYXBzIGFyZSByZXN0b3JlZC4KCiAtIEFkZGluZyBuZXcgaW50ZXJm
YWNlcyBrW3VuXW1hcF90ZW1wb3JhcnkqKCkgd2hpY2ggYXJlIG5vdCBkaXNhYmxpbmcKICAgcHJl
ZW1wdGlvbiBhbmQgY2FuIGJlIGNhbGxlZCBmcm9tIGFueSBjb250ZXh0IChleGNlcHQgTk1JKS4K
CiAgIENvbnRyYXJ5IHRvIGttYXAoKSB3aGljaCBwcm92aWRlcyBwcmVlbXB0aWJsZSBhbmQgInBl
cnNpc3RhbnQiIG1hcHBpbmdzLAogICB0aGVzZSBpbnRlcmZhY2VzIGFyZSBtZWFudCB0byByZXBs
YWNlIHRoZSB0ZW1wb3JhcnkgbWFwcGluZ3MgcHJvdmlkZWQgYnkKICAga21hcF9hdG9taWMqKCkg
dG9kYXkuCgpUaGlzIGFsbG93cyB0byBnZXQgcmlkIG9mIGNvbmRpdGlvbmFsIG1hcHBpbmcgY2hv
aWNlcyBhbmQgYWxsb3dzIHRvIGhhdmUKcHJlZW1wdGlibGUgc2hvcnQgdGVybSBtYXBwaW5ncyBv
biA2NGJpdCB3aGljaCBhcmUgdG9kYXkgZW5mb3JjZWQgdG8gYmUKbm9uLXByZWVtcHRpYmxlIGR1
ZSB0byB0aGUgaGlnaG1lbSBjb25zdHJhaW50cy4gSXQgY2xlYXJseSBwdXRzIG92ZXJoZWFkIG9u
CnRoZSBoaWdobWVtIHVzZXJzLCBidXQgaGlnaG1lbSBpcyBzbG93IGFueXdheS4KClRoaXMgaXMg
bm90IGEgd2hvbGVzYWxlIGNvbnZlcnNpb24gd2hpY2ggbWFrZXMga21hcF9hdG9taWMgbWFnaWNh
bGx5CnByZWVtcHRpYmxlIGJlY2F1c2UgdGhlcmUgbWlnaHQgYmUgdXNhZ2Ugc2l0ZXMgd2hpY2gg
cmVseSBvbiB0aGUgaW1wbGljaXQKcHJlZW1wdCBkaXNhYmxlLiBTbyB0aGlzIG5lZWRzIHRvIGJl
IGRvbmUgb24gYSBjYXNlIGJ5IGNhc2UgYmFzaXMgYW5kIHRoZQpjYWxsIHNpdGVzIGNvbnZlcnRl
ZCB0byBrbWFwX3RlbXBvcmFyeS4KCk5vdGUsIHRoYXQgdGhpcyBpcyBvbmx5IGxpZ2h0bHkgdGVz
dGVkIG9uIFg4NiBhbmQgY29tcGxldGVseSB1bnRlc3RlZCBvbgphbGwgb3RoZXIgYXJjaGl0ZWN0
dXJlcy4KClRoZXJlIGlzIGFsc28gYSBzdGlsbCB0byBiZSBpbnZlc3RpZ2F0ZWQgcXVlc3Rpb24g
ZnJvbSBMaW51cyBvbiB0aGUgaW5pdGlhbApwb3N0aW5nIHZlcnN1cyB0aGUgcGVyIGNwdSAvIHBl
ciB0YXNrIG1hcHBpbmcgc3RhY2sgZGVwdGggd2hpY2ggbWlnaHQgbmVlZAp0byBiZSBtYWRlIGxh
cmdlciBkdWUgdG8gdGhlIGFiaWxpdHkgdG8gdGFrZSBwYWdlIGZhdWx0cyB3aXRoaW4gYSBtYXBw
aW5nCnJlZ2lvbi4KClRob3VnaCBJIHdhbnRlZCB0byBzaGFyZSB0aGUgY3VycmVudCBzdGF0ZSBv
ZiBhZmZhaXJzIGJlZm9yZSBpbnZlc3RpZ2F0aW5nCnRoYXQgZnVydGhlci4gSWYgdGhlcmUgaXMg
Y29uc2Vuc3VzIGluIGdvaW5nIGZvcndhcmQgd2l0aCB0aGlzLCBJJ2xsIGhhdmUgYQpkZWVwZXIg
bG9vayBpbnRvIHRoaXMgaXNzdWUuCgpUaGUgbG90IGlzIGF2YWlsYWJsZSBmcm9tCgogICBnaXQ6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQg
aGlnaG1lbQoKSXQgaXMgYmFzZWQgb24gUGV0ZXIgWmlqbHN0cmFzIG1pZ3JhdGUgZGlzYWJsZSBi
cmFuY2ggd2hpY2ggaXMgY2xvc2UgdG8gYmUKbWVyZ2VkIGludG8gdGhlIHRpcCB0cmVlLCBidXQg
c3RpbGwgbm90IGZpbmFsaXplZDoKCiAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9wZXRlcnovcXVldWUuZ2l0IHNjaGVkL21pZ3JhdGUtZGlzYWJsZQoKQ2hh
bmdlcyB2cy4gVjE6CgogIC0gTWFrZSBpdCB0cnVseSBmdW5jdGlvbmFsIGJ5IGRlcGVuZGluZyBv
biBtaWdyYXRlIGRpc2FibGUvZW5hYmxlIChCcm93biBwYXBlcmJhZykKICAtIFJlbmFtZSB0byBr
bWFwX2xvY2FsLiogKExpbnVzKQogIC0gRml4IHRoZSBzY2hlZCBpbi9vdXQgaXNzdWUgTGludXMg
cG9pbnRlZCBvdXQKICAtIEZpeCBhIGZldyBzdHlsZSBpc3N1ZXMgKENocmlzdG9waCkKICAtIFNw
bGl0IGEgZmV3IHRoaW5ncyBvdXQgaW50byBzZXBlcmF0ZSBwYXRjaGVzIHRvIG1ha2UgcmV2aWV3
IHNpbXBsZXIKICAtIFBpY2sgdXAgYWNrZWQvcmV2aWV3ZWQgdGFncyBhcyBhcHByb3ByaWF0ZQoK
VGhhbmtzLAoKCXRnbHgKLS0tCiBhL2FyY2gvYXJtL21tL2hpZ2htZW0uYyAgICAgICAgICAgICAg
IHwgIDEyMSAtLS0tLS0tLS0tLS0tLS0tLS0KIGEvYXJjaC9taWNyb2JsYXplL21tL2hpZ2htZW0u
YyAgICAgICAgfCAgIDc4IC0tLS0tLS0tLS0tLQogYS9hcmNoL25kczMyL21tL2hpZ2htZW0uYyAg
ICAgICAgICAgICB8ICAgNDggLS0tLS0tLQogYS9hcmNoL3Bvd2VycGMvbW0vaGlnaG1lbS5jICAg
ICAgICAgICB8ICAgNjcgLS0tLS0tLS0tLQogYS9hcmNoL3NwYXJjL21tL2hpZ2htZW0uYyAgICAg
ICAgICAgICB8ICAxMTUgLS0tLS0tLS0tLS0tLS0tLS0KIGFyY2gvYXJjL0tjb25maWcgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAxIAogYXJjaC9hcmMvaW5jbHVkZS9hc20vaGlnaG1lbS5oICAg
ICAgICB8ICAgIDggKwogYXJjaC9hcmMvbW0vaGlnaG1lbS5jICAgICAgICAgICAgICAgICB8ICAg
NDQgLS0tLS0tCiBhcmNoL2FybS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSAK
IGFyY2gvYXJtL2luY2x1ZGUvYXNtL2hpZ2htZW0uaCAgICAgICAgfCAgIDMxICsrKy0KIGFyY2gv
YXJtL21tL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgICAxIAogYXJjaC9jc2t5L0tjb25m
aWcgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgCiBhcmNoL2Nza3kvaW5jbHVkZS9hc20vaGln
aG1lbS5oICAgICAgIHwgICAgNCAKIGFyY2gvY3NreS9tbS9oaWdobWVtLmMgICAgICAgICAgICAg
ICAgfCAgIDc1IC0tLS0tLS0tLS0tCiBhcmNoL21pY3JvYmxhemUvS2NvbmZpZyAgICAgICAgICAg
ICAgIHwgICAgMSAKIGFyY2gvbWljcm9ibGF6ZS9pbmNsdWRlL2FzbS9oaWdobWVtLmggfCAgICA2
IAogYXJjaC9taWNyb2JsYXplL21tL01ha2VmaWxlICAgICAgICAgICB8ICAgIDEgCiBhcmNoL21p
Y3JvYmxhemUvbW0vaW5pdC5jICAgICAgICAgICAgIHwgICAgNiAKIGFyY2gvbWlwcy9LY29uZmln
ICAgICAgICAgICAgICAgICAgICAgfCAgICAxIAogYXJjaC9taXBzL2luY2x1ZGUvYXNtL2hpZ2ht
ZW0uaCAgICAgICB8ICAgIDQgCiBhcmNoL21pcHMvbW0vaGlnaG1lbS5jICAgICAgICAgICAgICAg
IHwgICA3NyAtLS0tLS0tLS0tLS0KIGFyY2gvbWlwcy9tbS9pbml0LmMgICAgICAgICAgICAgICAg
ICAgfCAgICAzIAogYXJjaC9uZHMzMi9LY29uZmlnLmNwdSAgICAgICAgICAgICAgICB8ICAgIDEg
CiBhcmNoL25kczMyL2luY2x1ZGUvYXNtL2hpZ2htZW0uaCAgICAgIHwgICAyMSArKy0KIGFyY2gv
bmRzMzIvbW0vTWFrZWZpbGUgICAgICAgICAgICAgICAgfCAgICAxIAogYXJjaC9wb3dlcnBjL0tj
b25maWcgICAgICAgICAgICAgICAgICB8ICAgIDEgCiBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
aGlnaG1lbS5oICAgIHwgICAgNiAKIGFyY2gvcG93ZXJwYy9tbS9NYWtlZmlsZSAgICAgICAgICAg
ICAgfCAgICAxIAogYXJjaC9wb3dlcnBjL21tL21lbS5jICAgICAgICAgICAgICAgICB8ICAgIDcg
LQogYXJjaC9zcGFyYy9LY29uZmlnICAgICAgICAgICAgICAgICAgICB8ICAgIDEgCiBhcmNoL3Nw
YXJjL2luY2x1ZGUvYXNtL2hpZ2htZW0uaCAgICAgIHwgICAgNyAtCiBhcmNoL3NwYXJjL21tL01h
a2VmaWxlICAgICAgICAgICAgICAgIHwgICAgMyAKIGFyY2gvc3BhcmMvbW0vc3JtbXUuYyAgICAg
ICAgICAgICAgICAgfCAgICAyIAogYXJjaC94ODYvaW5jbHVkZS9hc20vZml4bWFwLmggICAgICAg
ICB8ICAgIDEgCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9oaWdobWVtLmggICAgICAgIHwgICAxMiAr
CiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9pb21hcC5oICAgICAgICAgIHwgICAxMyAtLQogYXJjaC94
ODYvbW0vaGlnaG1lbV8zMi5jICAgICAgICAgICAgICB8ICAgNTkgLS0tLS0tLS0tCiBhcmNoL3g4
Ni9tbS9pbml0XzMyLmMgICAgICAgICAgICAgICAgIHwgICAxNSAtLQogYXJjaC94ODYvbW0vaW9t
YXBfMzIuYyAgICAgICAgICAgICAgICB8ICAgNTcgLS0tLS0tLS0KIGFyY2gveHRlbnNhL0tjb25m
aWcgICAgICAgICAgICAgICAgICAgfCAgICAxIAogYXJjaC94dGVuc2EvaW5jbHVkZS9hc20vaGln
aG1lbS5oICAgICB8ICAgIDkgKwogYXJjaC94dGVuc2EvbW0vaGlnaG1lbS5jICAgICAgICAgICAg
ICB8ICAgNDQgLS0tLS0tCiBiL2FyY2gveDg2L0tjb25maWcgICAgICAgICAgICAgICAgICAgIHwg
ICAgMyAKIGluY2x1ZGUvbGludXgvaGlnaG1lbS5oICAgICAgICAgICAgICAgfCAgMjAzICsrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0KIGluY2x1ZGUvbGludXgvaW8tbWFwcGluZy5oICAg
ICAgICAgICAgfCAgIDQyICsrKysrLQogaW5jbHVkZS9saW51eC9wcmVlbXB0LmggICAgICAgICAg
ICAgICB8ICAgMzggLS0tLS0KIGluY2x1ZGUvbGludXgvc2NoZWQuaCAgICAgICAgICAgICAgICAg
fCAgIDExICsKIGtlcm5lbC9lbnRyeS9jb21tb24uYyAgICAgICAgICAgICAgICAgfCAgICAyIAog
a2VybmVsL2ZvcmsuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgCiBrZXJuZWwvc2No
ZWQvY29yZS5jICAgICAgICAgICAgICAgICAgIHwgICAzMCArKystCiBrZXJuZWwvc2NoZWQvc2No
ZWQuaCAgICAgICAgICAgICAgICAgIHwgICAgMiAKIGxpYi9zbXBfcHJvY2Vzc29yX2lkLmMgICAg
ICAgICAgICAgICAgfCAgICAyIAogbW0vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgIDMgCiBtbS9oaWdobWVtLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIxOCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiA1NCBmaWxlcyBjaGFuZ2VkLCA1NDIg
aW5zZXJ0aW9ucygrKSwgOTY5IGRlbGV0aW9ucygtKQoK
