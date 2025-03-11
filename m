Return-Path: <linux-arch+bounces-10669-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEFEA5CCD6
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 18:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2370179EBD
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 17:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D0C263C80;
	Tue, 11 Mar 2025 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7lqW0Bh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085426281D;
	Tue, 11 Mar 2025 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715483; cv=none; b=RciUVK+e6pVPqPpDeVYJboiQNe41YPHQwvR35g+bv/Z9TPH8GjYq8QZa5zgZ/runLDNtIu6v9pLL9qh3N+J7lnmeOqPx6c2iuQt1xWLJSdB++THOXgdPXOd5W8ubjz1FyAGYOuI+zQKvhgUfcG1Qz1h2Caz1F7HNRJ4vkk9Zei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715483; c=relaxed/simple;
	bh=rJ3LCTBUh/AlhYx5Xte/+GOdfcnJfnNdtdlYniZRPjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVmjXeVLfaoPogrysMVxRpz9kB2WlFo+c4ttbxFqDkuYrHBwLZ/4193OyHus9NS6OrTVkOFnPOj94AqCifWer7ucs5E12MDN/8du5ozSUoNVdjU/FMN2wqnpmMg0qEk/ydFkM10Pavmpi0lJo0KMf93FDj/e19A7ZnRNC1RYg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7lqW0Bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9EEC4CEE9;
	Tue, 11 Mar 2025 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715482;
	bh=rJ3LCTBUh/AlhYx5Xte/+GOdfcnJfnNdtdlYniZRPjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7lqW0BhH4JXwI4jiu6GyxAZAxXX2VM3sh85ojDShZEYRyiOiAIyEkhOtZ7hfMtvy
	 tOARJAKc/XOr8HkHQgnESzf46nTOwQpYxv+VbKTBDGanOiHNBLNarT/LApjatIOU3h
	 V+gzpREkKYeMWVJfi0Mq1DYUhcivzcbYx6ARKFsC1VNwaQniuXszFbZy+07+vc/BkB
	 wHX+2Dx75fs4TXarNO/TbYHwdF0kNhFylFgJmMQiZLY+auwmWcvLoZ8aTYUdSjPHAh
	 Wo/NRJrAyTTTC2kweqRYC1MFSbHoUjwJm/x5uRYOxNwJ/32pj6jzXYDFLJkAN53RuN
	 FnoR2/9ZtgJXA==
Date: Tue, 11 Mar 2025 17:51:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 10/13] arch, mm: set high_memory in free_area_init()
Message-ID: <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk>
Mail-Followup-To: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
References: <20250306185124.3147510-1-rppt@kernel.org>
 <20250306185124.3147510-11-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CW3GEQDFsKL6WAUW"
Content-Disposition: inline
In-Reply-To: <20250306185124.3147510-11-rppt@kernel.org>
X-Cookie: To err is humor.


--CW3GEQDFsKL6WAUW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 08:51:20PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>=20
> high_memory defines upper bound on the directly mapped memory.
> This bound is defined by the beginning of ZONE_HIGHMEM when a system has
> high memory and by the end of memory otherwise.
>=20
> All this is known to generic memory management initialization code that
> can set high_memory while initializing core mm structures.
>=20
> Remove per-architecture calculation of high_memory and add a generic
> version to free_area_init().

This patch appears to be causing breakage on a number of 32 bit arm
platforms, including qemu's virt-2.11,gic-version=3D3.  Affected platforms
die on boot with no output, a bisect with qemu points at this commit and
those for physical platforms appear to be converging on the same place.

Bisect log:

# bad: [eea255893718268e1ab852fb52f70c613d109b99] Add linux-next specific f=
iles for 20250311
# good: [97654dc13f139ea726042711a4943f424c5d5b83] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [5cd09a324588b4554c9ed89cef34fa502a097d16] fs/proc/task_mmu: reduce=
 scope of lazy mmu region
# good: [8a7e7a03e3c53cd9abbbf233899cc2e05b2c6ec0] ASoC: SOF: Intel: Add su=
pport for ACE3+ mic privacy
# good: [1ec3f1dc215d4b3d3679ecdc4a549d4e82b3a609] ASoC: dmic: add regulato=
r support
# good: [69823334200029767de785d30acf74e4872a11d3] ASoC: SOF: Intel: mtl: S=
plit up dsp_ops setup code
# good: [db91ad81a2545eb82aa47d0306bc3e1adb05e336] ASoC: dt-bindings: fsl,i=
mx-asrc: Document audio graph port
# good: [a8fed0bddf8fa239fc71dc5c035d2e078c597369] ASoC: dt-bindings: add r=
egulator support to dmic codec
# good: [0d2d276f53ea3ba1686619cde503d9748f58a834] ASoC: SOF: Intel: lnl/pt=
l: Only set dsp_ops which differs from MTL
# good: [8aeb7d2c3fc315e629d252cd601598a5af74bbb0] ASoC: SOF: Intel: Create=
 ptl.c as placeholder for Panther Lake features
# good: [4a43c3241ec3465a501825ecaf051e5a1d85a60b] ASoC: SOF: Intel: ptl: A=
dd support for mic privacy
# good: [80416226920c21e806f93bd0930d67557f41600f] ASoC: SOF: Intel: mtl: S=
top exporting dsp_ops callback functions
# good: [d3321a20b5111a66f3e68798959a347acfccbd44] ASoC: dmic: add regulato=
r support
# good: [eea84a7f0cdb693c261a7cf84bd4b3d81479c9a6] ASoC: SOF: ipc4: Add sup=
port for Intel HW managed mic privacy messaging
# good: [0978e8207b61ac6d51280e5d28ccfff75d653363] ASoC: SOF: Intel: hda-ml=
ink: Add support for mic privacy in VS SHIM registers
# good: [a0db661e7d8e084e9cf3b9cdca7c6e4e66f2e849] ASoC: SOF: hda/shim: Add=
 callbacks to handle mic privacy change for sdw
# good: [02a838b01b8e7c00e2efe78db06fff356a112dec] spi: dt-bindings: fsl-lp=
spi: Add i.MX94 support
# good: [5d5eceb9bb1050774dadc6919a258729f276fd00] ASoC: soc-dai: add snd_s=
oc_dai_mute_is_ctrled_at_trigger()
# good: [3707fd9c383fc7ae19733a3ad2e5a82bf86370a0] spi: stm32: Remove unnec=
essary print function dev_err()
# good: [7a2ff0510c51462c0a979f5006d375a2b23d46e9] ASoC: soc-pcm: reuse dpc=
m_state_string()
# good: [269b844239149a9bbaba66518db99ebb06554a15] ASoC: dapm: Fix changes =
to DECLARE_ADAU17X1_DSP_MUX_CTRL
# good: [7dfc9bdde9fa20cf1ac5cbea97b0446622ca74c7] spi: stm32-ospi: Fix an =
IS_ERR() vs NULL bug in stm32_ospi_get_resources()
# good: [2c2eadd07e747059ccd65e68cd1d1b23ca96b072] ASoC: cs42l43: convert t=
o SYSTEM_SLEEP_PM_OPS
# good: [c6141ba0110f98266106699aca071fed025c3d64] ASoC: Merge up fixes
# good: [a1462fb8b5dd1018e3477a6861822d75c6a59449] ASoC: Intel: boards: upd=
ates for 6.15
# good: [1ff07522690d2c2b67343099d2d046e88f71cddb] ASoC: Intel: soc-acpi-in=
tel-lnl-match: add cs42l43 6x cs35l56 support
# good: [ffe450cb6bce16eb15f6bf90b85b7e5f9bfbc1e3] ASoC: Intel: soc-acpi-in=
tel-ptl-match: add rt713_vb_l3_rt1320_l12 support
# good: [65e246d33dede0008f281d3d09b7695bef2d18eb] ASoC: sdw_utils: add mic=
 and amp dais to 0xaaaa codec
# good: [c7a6a74f847923bb726029b85a3fd0e05e9fbb04] ASoC: Intel: soc-acpi-in=
tel-ptl-match: add sdw multi function mockup codec
# good: [02467341e3577836648753a9e9a5c196f08187da] ASoC: Intel: soc-acpi-in=
tel-ptl-match: add rt712_vb_l3_rt1320_l2 support
# good: [438405704eec45c06be9adc94eb5f94855412790] ASoC: Intel: soc-acpi-in=
tel-lnl-match: add sdw multi function mockup codec
# good: [8b36447c9ae102539d82d6278971b23b20d87629] ASoC: Intel: adl: add 2x=
rt1316 audio configuration
# good: [e1a0657c6d943528ef58671594ca7e5b17db5394] ASoC: Intel: add multi-f=
unction SDW mockup codec match
# good: [7172d9ae29afd00c8ee9a8e3a4eba4cea5d5e403] ASoC: Intel: soc-acpi-in=
tel-ptl-match: add cs42l43 6x cs35l56 support
# good: [b92bc4d6e21f1802a39975e3c7cc4f76f591d46f] ASoC: soc-pcm: merge soc=
_pcm_hw_update_format/subformat()
# good: [de22dc76e11d1291d4f50b73dbbaa158ba9d6acd] ASoC: doc: use SND_SOC_D=
AILINK_xxx() macro
# good: [6db63090272768785e6bb4a3afa16650c1e96c54] ASoC: Tidy up SOC_DOUBLE=
_* and SOC_SINGLE_* helpers
# good: [426aae69373fb149e5bbe1d5fa18299d38414f22] ASoC: fsl_audmix: suppor=
t audio graph card for audmix
# good: [ee3cce59b1cecad7edd2022a443c8607faa9a4ad] ASoC: use inclusive lang=
uage for
# good: [2cb6290a24f74f1c4a1b4cbd311ddd50a2c6046a] Tidy up ASoC VALUE contr=
ol macros
# good: [d6c08418955a7d88bd5fe18787456264c4408e22] ASoC: samsung: GPIO desc=
riptor conversion
# good: [24056de9976dfc33801d2574c1672d91f840277a] ASoC: codecs: Update dev=
ice_id tables for Realtek
# good: [56e8bbb7a0d1b15a1af87fc7d6a73469f6ed4bd2] ASoC: audio-graph-card2-=
custom-sample: Separate Sample
# good: [0a22454ab2eca530702b2689858909b608953703] ASoC: samsung: tm2_wm511=
0: Drop unused include
# good: [5fac6c2785f95ddd73db33289dcd3cd5a68be226] Add STM32MP25 SPI NOR su=
pport
# good: [c095b7a27529d1d18b3b36a47f77a1419f0de939] ASoC: samsung: tobermory=
: Drop unused include
# good: [5c06f7f3d8374df1cec3b353306a4d1032a60f44] ASoC: samsung: lowland: =
Drop unused include
# good: [b19d340d5d08c5940ce612c2a1b5fe3a8a401f9d] ASoC: samsung: bells: Dr=
op unused include
# good: [1d251a7adc5b720a71641c758a45b8a119971d80] ASoC: dt-bindings: evere=
st,es8328: Mark ES8388 compatible with ES8328
# good: [8243a49145e59f19032b86b20d8906f05e31bdcc] ASoC: dt-bindings: evere=
st,es8328: Require reg property
# good: [79c080c75cdd0a5ba38be039f6f9bb66ec53b0c4] ASoC: mediatek: mt6359: =
Fix DT parse error due to wrong child node name
# good: [da9146c19b1774926148ff271c4a3dc8d7891b18] ASoC: samsung: speyside:=
 Convert to GPIO descriptor
# good: [c4b2d9643a06a5326a778c4d77d6fa60e0f3d6b1] ASoC: samsung: littlemil=
l: Drop unused include
# good: [516493232a9b80dd4f4f6b078541cfad00973dbb] ASoC: wm9713: Use SOC_DO=
UBLE_EXT() helper macro
# good: [bf19467b8512f855bdfae59ae78d326b1f434443] ASoC: wm9712: Use SOC_SI=
NGLE_EXT() helper macro
# good: [c951b20766f019a263b3547b07627be52fff87b4] ASoC: dapm: Use ASoC con=
trol macros where possible
# good: [7c5b07b497eab8eba75cf5da00cba493216dfc12] ASoC: atmel: tse850-pcm5=
142: Use SOC_SINGLE_EXT() helper macro
# good: [aecdaa84adafb086b5b2939898d781bd63d6fe2e] ASoC: tas2562: Use SOC_S=
INGLE_EXT_TLV() helper macro
# good: [b2b6913394488e031ee3d726f247b1c967057b40] ASoC: rt715: Remove dupl=
icate SOC_DOUBLE_R_EXT() helper macro
# good: [1743dbb45b2cbe5500068900794a355a7e0dd853] ASoC: Tidy up SOC_DOUBLE=
_R_* helpers
# good: [98413be56faa1c12494f43e7f77746763fa41c4a] ASoC: wsa881x: Use SOC_S=
INGLE_EXT_TLV() helper macro
# good: [9e6e7e088cb78ce58ea442106b1f29cd7b6ff76e] ASoC: dapm: Add missing =
SOC_DAPM_DOUBLE_R_TLV() helper
# good: [9bb7d7452363fc470b76766b0a6356807e752795] ASoC: wcd938x: Use SOC_S=
INGLE_EXT_TLV() helper macro
# good: [17ec58ac3c08c5c43bbdf5b08020fa4188a3009a] ASoC: sma1307: Use SOC_S=
INGLE_EXT() helper macro
# good: [c01a74844b74c584160d5253f794bbd2af015bec] ASoC: Remove unused help=
er macro
# good: [e33d0569d7a1d041e37fb93094e70807856531c2] ASoC: mediatek: mt8183-m=
t6358-ts3a227-max98357: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [836d2924c05edb06e32eeede8bc12c4c96da0b3d] ASoC: intel: rt274: use =
inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [d8c808af2a9bf731f72fcb772cf22886c6d00d99] ASoC: mediatek: mt7986-d=
ai-etdm: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [1af0148c3f871e55a6c4adf544af77a19fd17671] ASoC: codec: arizona: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [d2f277bf8aaed8c5307ab998b2de4346bed6e884] ASoC: intel: max98357a: =
use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [db9912ce99c346c948c8fa774c0afc7d80d0ec20] ASoC: mediatek: mt8365-m=
t6357: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [f0bd6cb02505eca6adbe2e3ad3445a2420637c19] ASoC: codec: wm8978: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [0808c1ab8d1a1222194d830870f6b2b47220b1d7] ASoC: intel: ssm4567: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [6dd61011a67e35b8d5f3b94193ed66d0c19ba425] ASoC: codec: lochnagar-s=
c: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [7c0572197faf3b6d6b27271455e76ac8ba84c43f] ASoC: audio-graph-card2-=
custom-sample2.dtsi: Separate Sample DT
# good: [cfb91be8f9c8e54e517a9a539012309101abcac5] ASoC: codec: wm9081: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [2c4a2b5d084b06e1a9fd2e85866b51f6118dd254] ASoC: samsung: littlemil=
l: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [bcb896a69864aec4dd0251732a380bcdbeff8c51] ASoC: intel: max98927: u=
se inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [cb1ebf6e20371208c49d59615bf4b46d92991fc4] ASoC: mediatek: mt8195-m=
t6359: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [c709a876b7de676d49b00b624b37d208e452cc7e] ASoC: mediatek: mt7986-w=
m8960: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [8410a099c88d1d720c9780b0ed716e544ea5a6d2] ASoC: rockchip: rk3399_g=
ru_sound: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [b15ea10972a1b4db23f7495003fccc6fe59e44bd] ASoC: tegra: tegra_wm890=
3: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [291b4eb984792fcc0bd3dec9ad9a69c3c6988951] ASoC: codec: wm8993: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [9ef6a439bc987753b7e5af5a926f05debe82bd1c] ASoC: samsung: lowland: =
use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [f5617b647c8597e2437b3899f520fdf65e0f277a] ASoC: intel: rt298: use =
inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [6d41096d7df609992479d6a3a43bc60e21b8e165] ASoC: intel: rt5514: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [d542f5bfa3e4e16aac6141abdd44bb8a2a6f0761] ASoC: codec: wm8990: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [b1f5886cca25a6957b5541031376e2c06c5bd621] ASoC: mediatek: mt2701-c=
s42448: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [79b8a705e26c08f8f09dd55f1dd56f2375973d2d] spi: stm32: Add OSPI dri=
ver
# good: [27f5e88fdc8ab577dbff389085ae6ad41e994ae7] ASoC: codec: src4xxx: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [1455b3857ca2d05966005f7172210f6bd00048c3] ASoC: samsung: tm2_wm511=
0: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [3d5f026256d985e8b81e7657a5430a9ff14e651c] ASoC: samsung: speyside:=
 use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [fd6bc2ba410bf7828dc2104bf78b51ccbb216c40] spi: dt-bindings: Introd=
uce qcom,spi-qpic-snand
# good: [25baeacd9c6307830e2ed9f586f81fc23d4d1002] ASoC: codec: wm8904: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [862123a0a41647bd130a2d0edefc76a52dc8b8f8] ASoC: mediatek: mt2701-w=
m8960: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [69e35d9bfd6ba2837fe18bebf97ea747ceb110d5] ASoC: samsung: snow: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [2d2223d742d968fec77ed056db9f158e7cb3ca94] ASoC: codec: wm8940: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [edca7ad57c50483ec81ab5b74ff1d71dca62e5cb] ASoC: rockchip: rockchip=
_max98090: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [06d07a4f5b98c71c696fa8f8718050b656ab99ba] ASoC: samsung: odroid: u=
se inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [697c58941c0a0d1a5ea3f323cf0231018d3ec4b3] ASoC: samsung: aries_wm8=
994: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [294a60e5e9830045c161181286d44ce669f88833] ASoC: fsl_audmix: regist=
er card device depends on 'dais' property
# good: [bed97e35786a7d0141d1ecaaace03c46b5435d75] dt-bindings: spi: Add ST=
M32 OSPI controller
# good: [ccf2a77a5d1504ca95c1ae5f37ed184e62dcd2f2] ASoC: intel: rt286: use =
inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [0d4291fa3a8945d97d26a6bac8a4068f116f2885] ASoC: codec: wm8991: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [3f97e52562dd1ad041f63c910a746eab695f40c1] ASoC: samsung: arndale: =
use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [c8c1ab2c5cb797fe455aa18b4ab7bf39897627f6] regulator: pca9450: Hand=
le hardware with fixed SD_VSEL for LDO5
# good: [99239dc5147ea4678e871e5c9d068a36f154558b] ASoC: rockchip: rk3288_h=
dmi_analog: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [38cc5b0bed6c57367dca3725d01857fa0876899a] ASoC: mediatek: mt8186-m=
t6366: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [feb849404a8b677aa6760d1539acf597e4574337] ASoC: SOF: Intel: hda-da=
i: Remove unnecessary bool conversion
# good: [522f5021cfb5a74e9b7aa3cbf365471f7a564c0a] ASoC: mediatek: mt8173-r=
t5650-rt5514: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [68084db5e7a5eb1e4901e2158565cfc59873756d] ASoC: codec: wm8974: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [2725c018785d52286dd5b4ff7e087d2ff455a1a8] ASoC: codec: wm8988: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [35492f84fbd6d790ad7f93bffaaa6823890c103a] ASoC: codec: wm8994: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [eeb25b3ca1ef57d57906295d829febbd30cf4d8d] ASoC: mediatek: mt8173-r=
t5650: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [521c04c6e32ac110d942fa0e11bea4b91cc3241d] ASoC: ux500: use inclusi=
ve language for SND_SOC_DAIFMT_CBx_CFx
# good: [597acf1a04bede55e3ad8a7922bba286c11112d3] ASoC: dt-bindings: fsl,a=
udmix: make 'dais' property to be optional
# good: [93b1fefd8b1a004c6c8f8c92085e7bfb694dfe98] ASoC: codec: wm8983: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [abcb9a1fd89144536f3ef604f700e94424867366] ASoC: dt-bindings: fsl,s=
ai: Document audio graph port
# good: [b73c2719c951868efc15181269a3caeb99157f29] ASoC: mediatek: mt8173-r=
t5650-rt5676: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [29664312a75e47f989ad32e43682746d8681a02b] ASoC: samsung: tobermory=
: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [a02c42d41af7d66db71ca43c52531c3253ebe35e] ASoC: codecs: wsa883x: I=
mplement temperature reading and hwmon
# good: [9c914ef3b876a6f6c0059b4f4323fc1b76fa05e4] ASoC: codec: wm9713: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [c6472392301fc15a09d5435f1f89421270aed81c] ASoC: codec: wm8962: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [7370a8fe5bd211042610ec200dcc83de5ccc50cd] ASoC: rockchip: rockchip=
_rt5645: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [d4ee06219f2fffb71e2a23fc5060fdd3c7bb2cf7] ASoC: mediatek: mt8192-m=
t6359-rt1015-rt5682: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [cc49a35ab19565c5eaef070755b6fba235f9d05a] ASoC: codec: wm8996: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [74da545ec6a8b41de96b4c350bb59dfe45c0d822] ASoC: codec: madera: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [04ea3e0d2e10642f0a0199081e9aa8fd5e1bbea6] ASoC: tegra: tegra_asoc_=
machine: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [7d73a1beaa9428ed4da7786725fcb1a20fd371ab] ASoC: audio-graph-card2-=
custom-sample.dtsi: remove original sample
# good: [541e0b4947a92f4bf1d60ef7e55f0a254d9c41a0] ASoC: codec: wm8960: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [9002421ebb1409e2f47062722aad598b561cf9eb] ASoC: mediatek: mt8365-d=
ai-i2s: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [5fee78e517ce0765def9387659fc56a1d5532c60] ASoC: dt-bindings: fsl,a=
udmix: Document audio graph port
# good: [7304d1909080ef0c9da703500a97f46c98393fcd] spi: spi-qpic: add drive=
r for QCOM SPI NAND flash Interface
# good: [0526b0b88c3092e38ba2d05f480b66bd5a1e1004] ASoC: mediatek: mt8365-d=
ai-pcm: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [4586b056956995754e95456312b2a9ce36c8de21] ASoC: meson: meson-card-=
utils: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [6575dd53217ee5686d48a35f48415b113518d2a9] ASoC: codec: sgtl5000: u=
se inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [c80956630fa077646f971ff5d3e9452339742def] ASoC: codec: twl4030: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [22e5c40fda71d0b6cdf83af9418403808d5d06bd] ASoC: audio-graph-card2-=
custom-sample1.dtsi: Separate Sample DT
# good: [4994da5c7fea1ede9b71ae66e3b906ea56b9a929] ASoC: intel: nau8825: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [7f3ed7ea52f21d5b8ecc01a17fb8f7209d337cbe] ASoC: codec: wm8985: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [b99c850bd41e8f6f142bb24c3c2485043b552621] ASoC: codec: wm8961: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [cc8e22b6b1622f44654a9ce70c1285c15c1b8414] ASoC: samsung: smdk_wm89=
94pcm: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [0f68f56ab7be101fc949177774107769e63f13e9] ASoC: soc-dai: remove SN=
D_SOC_DAIFMT_CB{MS}_CF{MS}
# good: [5dc6b4a351de9804932c4475a2c73c22c0b59369] ASoC: samsung: bells: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [e15abfa60107f97fd8297faad8cc3dc4eae0b5cc] ASoC: intel: da7219: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [22bbcab0a2a100827a26833b7cab16ae8b1a3f9e] ASoC: samsung: midas_wm1=
811: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [fb44bd4902cd5df526ad432015edcfaf163999e2] ASoC: codec: wm8955: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [6cc4d2c11537d66e9d4a7356a576f1bea6f4009f] ASoC: meson: t9015: use =
inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [795aad6b179de4c3f68b18132bd183931d09c462] ASoC: samsung: smdk_wm89=
94: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [711035c043b3a5116860b3a25d808572f70e1dc1] ASoC: mediatek: mt8183-d=
a7219-max98357: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [ed86f7b7e5f676c24ba0ddd86de6614a4b69a9e4] ASoC: codec: wm8971: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [c417a7cf976eb8ecd8ebca439ec0cb0fe9ddc7ec] ASoC: codec: wm8995: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [47c59833c42a99bd27826f4f369bf4bb433c7ff9] ASoC: mediatek: mt8173-m=
ax98090: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [1c418cf146380031b13b6fde02f944830e5b9155] ASoC: codecs: rt5514: Fi=
x definition of device_id tables
# good: [ad3993c449637fcec1e05bd2b63c24d34cb82243] ASoC: codec: wm8804: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [e2bcc61a4481c3de4747014895cef45d701956bf] ASoC: codec: wm8523: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [9b9cbc6b4fa312d963f4373e88b6e27106f2051a] ASoC: codec: wm8776: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [8f5ae83953335d9c4c8d1cb698b87cea1ac8aeca] ASoC: codec: cs42l73: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [9aa85f433bb1f51b599278b29b3d6224ca5147cf] ASoC: codecs: rt5670: Fi=
x definition of device_id tables
# good: [48d5e50e4fe78bf9cc5b4eca72798d4507da62fb] ASoC: ti: ams-delta: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [dc946ef548aeeea258b040087b88c9b7fae5cb6d] ASoC: codec: cs43130: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [e5f0c2ad987b494ab94bcb1331667d189249f234] ASoC: codec: da732x: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [a06ef7754b8e6f45d78c0015c3edb2117945adfb] ASoC: codecs: rt5668: Fi=
x definition of device_id tables
# good: [a212edb16ca0698c488c6adfa6854224666c8cc1] ASoC: codec: rt286: use =
inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [f8ca280bf5c2a3fb08890bdd212a3f3c00589f87] ASoC: qcom: sc7280: use =
inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [952b334dcfcf641a6290b876bdc226c23772287e] ASoC: codec: cs42l42: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [bb0b8a07192d86b291c5b13fb64ef984930f8ea6] ASoC: codec: wm8737: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [90fd7bb1af1733685f0aece12dd7264d4ef68422] ASoC: codec: cs42xx8: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [bc17eaf1b925595fb9f945ced5d70fe82ce11e78] ASoC: ti: davinci-evm: u=
se inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [4869417f4a2b010e9ee00f611265f551a47e4f1a] ASoC: codec: rt5668: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [0c57e55719681412e87db7bb81b8255b43d6162f] ASoC: codec: cs530x: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [74f6e045d879414ae4c352dc7f4e8d438ea9d55d] ASoC: mxs: use inclusive=
 language for SND_SOC_DAIFMT_CBx_CFx
# good: [4d34ea6709894243d55ae6a6b63834851f9c5d6f] ASoC: codecs: rt5660: Fi=
x definition of device_id tables
# good: [1fca457c22a277ba47ae1bdd2a09d42926a5beed] ASoC: codec: nau8822: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [668db717850296122fa0e2aff471cd20a722e0c5] ASoC: codec: rt1308: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [0b74ed5533c87db1abe3967e3a370bc3046892c7] ASoC: codec: rt5665: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [d17b39f6d3e635b039314726fbc66dcef286ed79] ASoC: codec: wm8770: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [7f15da9a55d3ba9f8c3af545246a4588102a38db] ASoC: codecs: rt286: Upd=
ate definition of device_id tables
# good: [a018b6601c47e7d989f1fe5c175325f85dceb264] ASoC: codec: wm8741: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [9261d67d8bd2d9e787ceee8ff593f105bb3f5176] ASoC: codec: rt1305: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [fad200733e5026b103ec2504ad3dfc2843216cc8] ASoC: codec: cs42l51: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [85188e3bd7cb4141181f24a59f9057c38ffa37bf] ASoC: codecs: rt5651: Fi=
x definition of device_id tables
# good: [e9d9a43e3f00b9313013b78d915a1f97dd215bf5] ASoC: codecs: rt5663: Fi=
x definition of device_id tables
# good: [dfdc0debf1b82354e301843f8cbd16eaf05a01c6] ASoC: ti: osk5912: use i=
nclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [67f2243f2b1f1936c4dc22897289f5815a0e224a] ASoC: codec: rt5660: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [0ad3a7d311f0e93f2e838b4e47a7da57c501d737] ASoC: codec: rt5663: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [b9dde447dd27f1b3ca21e07da1d885fd342cfa62] ASoC: codec: cs42l56: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [e9ab4b38205a34fffe537b4db721458b5d07066e] ASoC: codec: cs4271: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [c974655b0c7f82a760bd22d9ef9db281e765a9a2] ASoC: codec: cs4265: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [8450fa6b16e2f46f5b880e0b80d55ab9fc4524ca] ASoC: Documentation: Cod=
ec to Codec: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [d3a37a664ebe57471bd7ab2486dd3072a9c07378] ASoC: codecs: rt5645: Fi=
x definition of device_id tables
# good: [461deb4911f39e455756cbc42928b12b04e82851] ASoC: codec: wm2200: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [2f8b07842e9e95122b848727ea73504a035e7c12] ASoC: codec: wm8900: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [92acd9f7409d2939e5fef8bde5ad527b9e525229] ASoC: codec: wm8753: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [dee14c5b6d29886255c4a54599590d49fc1754be] ASoC: codec: wm8524: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [46dbe25747fca3d82e98dca488fa9be6b809d522] ASoC: codec: cs4270: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [df95f0157ba1ea7b73b3f1db4abfdb4b05e0bfd9] ASoC: amd: use inclusive=
 language for SND_SOC_DAIFMT_CBx_CFx
# good: [2f120ee8026ab9630dc7f93dd4bafdcd56c82056] ASoC: codec: nau8825: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [24684cc2060150afd7a1ea47c586f9c09330633c] ASoC: codec: wm8400: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [ed4bef1d52ce0d6c96a86b6a470d6777034c564c] ASoC: codecs: rt298: Upd=
ate definition of device_id tables
# good: [941abe67e176a3ddbe59cd4323b13f69515f6628] ASoC: ti: omap3pandora: =
use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [5cfb2f62242b41e2b60cadf21b28ee43cf615ec2] ASoC: ti: j721e-evm: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [b26c604a0dcef62e7c61bd1d560c63547c9bbfe8] ASoC: codec: cs35l32: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [4be54b6bdafad7656fd85c1fa6b7bebb7700a3d2] ASoC: codec: wm8750: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [24a4302478118ff1caf39fb48809c0127f608664] ASoC: codecs: rt5659: Fi=
x definition of device_id tables
# good: [6de7c4def7a6bf967d6603f7e1abda5231ccc312] ASoC: codecs: rt5682: Fi=
x definition of device_id tables
# good: [4d20a35acef6fb8c42eff953a11759e94710ba8b] ASoC: codec: wm8728: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [f1205656ef2334e860ced588e76dd88119394166] ASoC: codec: rt5659: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [e759aeeb1d09147891e08682df3a70dfbd15724a] ASoC: codec: cs53l30: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [9c7cf29bdb11cfdd1b59d1ea1eb852245b26e93a] ASoC: codec: rt274: use =
inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [fc0a8ee9921f50ac23b3264846720d1d15be539e] ASoC: codec: da7219: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [1a126668ab0946ebb7d1450742cd14775aa298fa] ASoC: codec: wm8903: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [2d5e9d40998b441485376b8729c69073d8f2ab9d] ASoC: codec: rt5616: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [1b16920e651d11811ca4b3a5d92cfb3d817b1a14] ASoC: codec: rt5631: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [dfc6b8ccb1bb8d591cd26571e554208fc4af7d0c] ASoC: codecs: rt5640: Fi=
x definition of device_id tables
# good: [e42ec97657fa5ee40fd2358c973d273edd7999bd] ASoC: pxa: use inclusive=
 language for SND_SOC_DAIFMT_CBx_CFx
# good: [739f4f44dc42b866090297adc1f007ffcdefb602] ASoC: codec: nau8540: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [3c2e63a3a0efa8c52f9fd67f58a71af48957ca7a] ASoC: codec: cs4234: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [5f2d29942c82d229dbdafe4bd21585d1b67f31ee] ASoC: codec: rk817: use =
inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [b89d9d26fb6cbc9f6e0aae72a2a76b5d8e5f1023] ASoC: codecs: rt5665: Fi=
x definition of device_id tables
# good: [d21e3b442ff6401511831ae1b8be11d530f063de] ASoC: codec: cs35l34: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [420663ae8fa2d70d2b824848763ca15bb5b2b585] ASoC: codec: wm8510: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [2920be2fabcb8010fefdf101d84fe0867730d925] ASoC: fsl: use inclusive=
 language for SND_SOC_DAIFMT_CBx_CFx
# good: [2281565db79b5fd6b539e73a28e73fc960ee34d4] ASoC: codec: rt1015: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [1b94f3874d61b34febd5ddf3482a90107dc80082] ASoC: codec: wm8580: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [9fde82ea39a7f52c23de366c8592d4805634f45c] ASoC: ti: omap-twl4030: =
use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [474cd6355413b264087ddc66b1dbc6c7e59fb76f] ASoC: codec: wm8350: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [6f8ac982806a104e4e816e12279d85440b6f703f] ASoC: codec: da9055: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [042ecb2ab2361f77b34a7d3c642bd378f6ecc73a] ASoC: codec: wm8711: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [f61c11db0f598eed6dd35a2d700ca54c6c74af4a] ASoC: codec: rt5682: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [b3a3eda6cb30f21b818f40795468ff0a9f629990] ASoC: codec: rt5670: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [4042bb6e973aded1de6ce83436804a90181d6357] ASoC: codec: wm5100: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [739db0529c2a3ac5a0dc3e5a76a46ce80735dcfa] ASoC: codecs: rt5677: Up=
date definition of device_id tables
# good: [a3c86259f8a402aa050fc5f3039f94c7872e4657] ASoC: codec: nau8810: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [1ef8b1c830a0b5a6600d803a8bbeb7179d3ca4da] ASoC: codec: cs42l52: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [b865e0823cbffb747173b7dd4f4c8d82491d111f] ASoC: codec: rt1011: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [40213f8d5b498f5eb2f3297ee0f9c84d98737ee9] ASoC: codec: rt5677: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [bd178280c7d967e87e217b51c0647a2bfdf5deec] ASoC: codec: rt5682s: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [ea38f63c4afdd5531fbd8f0f881594a94c4bd413] ASoC: codec: cs35l33: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [a1cadae42c9bc52cff24b22b0c4986be8d82ae16] ASoC: qcom: sc7180: use =
inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [5a84cbb03094fd903ed79ca6c06e558821a69be4] ASoC: codecs: rt274: Fix=
 definition of device_id tables
# good: [231bf041d425a086ec08231c98cf02b6fb16b169] ASoC: ti: n810: use incl=
usive language for SND_SOC_DAIFMT_CBx_CFx
# good: [e41ebb0a1f8bff63c8e333eec34ff64e748227d0] ASoC: codec: rt5651: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [b50e5b9694e2a4355f2abeaa711dae5190661c27] ASoC: codec: da7210: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [3165df2f130d567e6cf05d789ecc28810519e5f7] ASoC: codec: rt5645: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [acac29fa62a8b738569a99da2f6458bc21aa55ae] ASoC: codecs: rt1318: Fi=
x definition of device_id tables
# good: [84f32702f3efe02c2622b9151d4e08c436249a8c] ASoC: codec: rt298: use =
inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [7177a7a8e10d7722d0b9d4be4eea7dde014527b9] ASoC: codec: da7218: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [e23d68d7d3b35a44eb83d834b65cd28ca08844ec] ASoC: codec: nau8824: us=
e inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [60143172c63daa49fef6eb9daa066fb7f1360bbe] ASoC: codec: rt5640: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [f9ef0947ba848467e4dcca6b5ab3a4ff2e218df6] ASoC: codec: rt1016: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [0d41068ca151a6368ab4591c13e9a7a9fb92a56f] ASoC: codec: cs4341: use=
 inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [30e03871146129acb75adac48405c203f5bdb3c2] ASoC: codecs: rt1308: Fi=
x definition of device_id tables
# good: [b686559772d1baa28e2ad346d5a9932863d9523c] ASoC: codecs: rt1011: Fi=
x definition of device_id tables
# good: [0440f938aacf54a3e7dc67cd898f76bbd371da49] ASoC: codecs: rt1305: Fi=
x definition of device_id tables
# good: [e7795c17b82684afb9390b8788f781c07be1a368] ASoC: codecs: rt1016: Fi=
x definition of device_id tables
# good: [a859d2383f66002a442218bf5083faaa674bc4e4] ASoC: codecs: rt1015: Fi=
x definition of device_id tables
# good: [689e4d5fd8a76c676f04bc8916d78ca5db3130db] ASoC: codecs: rt1019: Fi=
x definition of device_id tables
# good: [5e9f822c9c683ae884fa5e71df41d1647b2876c6] iommu: Swap the order of=
 setting group->pasid_array and calling attach op of iommu drivers
# good: [c5c4ce6612bb25ce6d6936d8ade96fcba635da54] regulator: cros-ec: use =
devm_kmemdup_array()
# good: [6ddd1159825c516b8f64fda83177c161434141f5] regulator: devres: use d=
evm_kmemdup_array()
# good: [1455f0badd6345b2606bafb32e719d252293ebcd] Convert regulator driver=
s to use
# good: [579a20181cf2e9ddc2f1265ee4976a0e2631fd5d] Convert sound drivers to=
 use devm_kmemdup_array()
# good: [c173b5ee81a25e8aafb21ccdb7ab457da7783bf1] ASoC: uniphier: use devm=
_kmemdup_array()
# good: [0bd862846e7f89910252cbef8718a757950f1683] ASoC: Intel: avs: use de=
vm_kmemdup_array()
# good: [3e706be02befae55b50b240d4360b5993f9879a8] ASoC: hdac_hdmi: use dev=
m_kmemdup_array()
# good: [d9d71a6e2d19a2f3ccebea0092b8ddc1e935886f] ASoC: uda1380: use devm_=
kmemdup_array()
# good: [b26205e172ca035e327e49edb0c2611e5d2ede8d] ASoC: meson: axg-tdm-int=
erface: use devm_kmemdup_array()
# good: [69aaab0e65e9bd7601740c1e14cc6de86dafb621] ASoC: tlv320dac33: use d=
evm_kmemdup_array()
# good: [d0343fdb567dddaa74ac1b7b6994fd70100a0f6e] Add SDCA register map su=
pport
# good: [c143755d8cce31e770234732ff23134993b0550f] ASoC: SDCA: Add helper t=
o write out defaults and fixed values
# good: [fd80df352ba1884ce2b62dd8d9495582308101b7] regcache: Add support fo=
r sorting defaults arrays
# good: [79ed408b2402e8113aa5a298f3bb9088ede58f6c] ASoC: mediatek: mt8188: =
avoid uninitialized variable use
# good: [28c12866c22c2826ccbd8c82dc353f02ab2deea5] ASoC: SDCA: Add regmap h=
elpers for parsing for DisCo Constant values
# good: [825687c1662c53ecda991adf0ecfd8dd3d864043] spi: dt-bindings: Add rk=
3562 support
# good: [e3f7caf74b795621252e3c25b4a9fb6888336ef1] ASoC: SDCA: Add generic =
regmap SDCA helpers
# good: [be1e3607f29a5a182eaa70e3058aef32fd0cc4f8] ASoC: tas2781: Clean up =
for some define
# good: [a54a659f5cc25e3b23ab19af08d0b23488bd9f4e] xlnx: dt-bindings: Conve=
rt to json-schema
# good: [a206376b425472c7c3a824f47a9967a4c97ae32c] ASoC: dt-bindings: xlnx,=
i2s: Convert to json-schema
# good: [1d2e01d53a8ebfffb49e8cc656f8c85239121b26] spi: spi-imx: convert ti=
meouts to secs_to_jiffies()
# good: [62142da241a08006f89b0620f7291e3a08c0a094] ASoC: rt712-sdca: Add FU=
05 playback switch control
# good: [7ed7065dfbbac1b5405a0c8029299847e408cf97] ASoC: dt-bindings: xlnx,=
spdif: Convert to json-schema
# good: [1b8b6dd0c91b7db58e344f01781932458ac43da3] ASoC: dt-bindings: xlnx,=
audio-formatter: Convert to json-schema
# good: [55a1abd6e76ce91eb6049f32efec3a8506686748] MAINTAINERS: Add Vincenz=
o Frascino as Xilinx Sound Driver Maintainer
# good: [32fcd1b9c397ccca7fde2fcbcf4fc7e0ec8f34aa] spi: spi-fsl-lpspi: conv=
ert timeouts to secs_to_jiffies()
# good: [dc64e1b9da22496b5867f90315ac406be041db15] Enable DMIC for Genio 70=
0/510 EVK
# good: [bf1800073f4d55f08191b034c86b95881e99b6fd] ASoC: mediatek: mt8188: =
Add reference for dmic clocks
# good: [b80fd34df2580f2c7a99e7188d68515bcf779714] Fix RK3588 power domain =
problems
# good: [38399716e353776dca7f04dbae98a07af68f2880] ASoC: ti: rx51: use incl=
usive language for SND_SOC_DAIFMT_CBx_CFx
# good: [6542db20caf4987b938ed8feec07d199779823f2] ASoC: dt-bindings: fsl,e=
asrc: Reference common DAI properties
# good: [390ebb24b3c3a95e109c28e14c2ec9fe3f0f8aaa] ASoC: mediatek: mt8188-m=
t6359: Add DMIC support
# good: [63d93f4d0f38fbb95a55729fbd2cc4920743931c] ASoC: q6dsp: q6apm: repl=
ace kzalloc() with kcalloc() in q6apm_map_memory_regions()
# good: [f9d4f699751f0389e57f26382174334670b8276e] ASoC: imx-card: support =
playback or capture only
# good: [d909b8d13a13d0197877e16aaaa3b2fcbb502858] ASoC: Intel: avs: Mute a=
nd multi-channel controls
# good: [ef6a24c79d5047c029577113af43eddd1d0f1bd2] ASoC: mediatek: mt8188: =
Add audsys hires clocks
# good: [f00b3056843d14754ac1bab2106cf5599680f115] ASoC: dt-bindings: media=
tek,mt8188-mt6359: Add DMIC backend to dai-link
# good: [22254fca9bc7655801ad5f2af15729e44d28b85c] ASoC: dt-bindings: fsl: =
Reference common DAI
# good: [3e7b375752b5e4de56e92dfb9c43309cd985b869] ASoC: dt-bindings: fsl,i=
mx-asrc: Reference common DAI properties
# good: [7d87bde21c73731ddaf15e572020f80999c38ee3] ASoC: mediatek: mt8188: =
Treat DMIC_GAINx_CUR as non-volatile
# good: [1c4749873bd0f769a47372636a428484e7035f59] ASoC: kirkwood: use incl=
usive language for SND_SOC_DAIFMT_CBx_CFx
# good: [c1e42ec04197ac013d049dde40d9c72cf543b5f6] ASoC: mediatek: mt8188: =
Add support for DMIC
# good: [8fd0e127d8da856e34391399df40b33af2b307e0] ASoC: amd: acp: acp70: R=
emove unnecessary if-check
# good: [5a09e179024e76afdf9ad3a6ae767b4e06884ea8] ASoC: Documentation: DPC=
M: use inclusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [a5a3de8990f47f4c54ca5daeeea8ff7daa42f9de] ASoC: sh: migor: use inc=
lusive language for SND_SOC_DAIFMT_CBx_CFx
# good: [4c32ebcc8650ce506632a32136993c85537fb01a] ASoC: Intel: avs: Move t=
o the new control operations
# good: [76e013152891a69dfe68a28706a51a7df9ed4c42] ASoC: Intel: avs: Honor =
the invert flag for mixer controls
# good: [10188a25c9b5944c0a912482011b484b7c2e22d4] ASoC: Intel: avs: Update=
 VOLUME and add MUTE IPCs
# good: [28feec15fa285e561c626b3490bc5a10f5d177c8] ASoC: Intel: avs: Make P=
EAKVOL configurable from topology
# good: [0dffacbbf8d044456d50c893adb9499775c489f4] regulator: Add (devm_)of=
_regulator_get()
# good: [1877c3e7937fb2b9373ba263a4900448d50917b7] ASoC: imx-card: Add play=
back_only or capture_only support
# good: [a4217a03686989c4a79530fe54fa17576aff7330] ASoC: Intel: avs: Add su=
pport for mute for PEAKVOL and GAIN
# good: [a9409fcb979eaff401837b955b234ca1ee05fdbd] ASoC: Intel: avs: Suppor=
t multi-channel PEAKVOL instantiation
# good: [81eb3a2bd273b84fa9808e6b13b533f9c55e16eb] ASoC: topology: Save num=
_channels value for mixer controls
# good: [c321a4d705a31a50d7580516422aaa5b853e7602] ASoC: Intel: avs: New vo=
lume control operations
# good: [8c6ede5cc4226fd841f252d02ab0372cb92ee75c] ASoC: dt-bindings: imx-c=
ard: Add playback-only and capture-only property
# good: [4c43a930e3e165ca6890147a309508ccb6768faf] ASoC: Intel: avs: Add vo=
lume control for GAIN module
# good: [758beab0252912395efb79f34095c5ae7e3e58b1] ASoC: topology: Create k=
controls based on their type
# good: [18311a766c587fc69b1806f1d5943305903b7e6e] err.h: move IOMEM_ERR_PT=
R() to err.h
# good: [2fa56dae1a65e8124d417a31d7b02c37df013817] ASoC: fsl: fsl_qmc_audio=
: Remove unnecessary bool conversions
# good: [91b75129149429bb16927cda8b5642c04c59e6b0] ASoC: SOF: amd: Move dep=
ends on AMD_NODE to consumers
# good: [99e297cdd338b8a18c986ed4e088676579b7fe96] iio: imu: st_lsm9ds0: Re=
place device.h with what is needed
# good: [a103b833ac3806b816bc993cba77d0b17cf801f1] devres: Introduce devm_k=
memdup_array()
# good: [10efa807929084a8a1c38655942a3bf83bce587a] ASoC: cros_ec_codec: Use=
 str_enable_disable() helper in wov_enable_put()
# good: [88e09306b7e0f8a9e9f9c729ac13ccd11ed9679d] ASoC: atmel: atmel-class=
d: Use str_enabled_disabled() helper
# good: [a21cad9312767d26b5257ce0662699bb202cdda1] driver core: Split devre=
s APIs to device/devres.h
# good: [b47834ee4485bbdcc6d36f086ff61c3efd8870d4] ASoC: SOF: amd: Add depe=
nds on CPU_SUP_AMD
# good: [64899904d6103500ad01be7b763298dc939285ae] ASoC: soc-core: Use str_=
yes_no() in snd_soc_close_delayed_work()
# good: [f3bfa0f07976a7996b6dedba21d2e0d164f08ce8] spi: dt-bindings: Conver=
t Freescale SPI bindings to YAML
# good: [2e2f89b184644f0e29f1ec0b4dcfd0361d2635cb] firmware: cs_dsp: test_b=
in_error: Use same test cases for adsp2 and Halo Core
# good: [42ae6e2559e63c2d4096b698cd47aaeb974436df] firmware: cs_dsp: test_c=
ontrol_parse: null-terminate test strings
# good: [cb15abd47806b449e853caf43f41573c4c82fed3] spi: s3c64xx: extend des=
cription of compatible's fifo_depth
# good: [66d8e76e8e85a30fbf9809837e07e15a8c5ccb8b] regulator: pca9450: Remo=
ve duplicate code in probe
# good: [c8d08464bce947ee060e0174a3f4e87503269d0c] ASoC: dt-bindings: atmel=
-at91sam9g20ek: convert to json-schema
# good: [f120cf33d2325fd95d063eccbff2e86ffc7f493a] ASoC: SOF: amd: Use AMD_=
NODE
# good: [67ebf71236f2e7b0e4cf791700dcddc9eb8cf650] Adjust all AMD audio dri=
vers to use AMD_NODE
# good: [40d05927830227f2a1701c61e8bbe65287a03490] ASoC: amd: acp: Drop loc=
al symbols for smn read/write
# good: [e211adcf36d0ccdd31af7398af4725a47d74b3d4] ASoC: amd: acp: rembrand=
t: Use AMD_NODE
# good: [135c6af1cac5465529469700d16c0c44b24ce317] ASoC: amd: acp: acp70: U=
se AMD_NODE
# good: [a261d77fec147b9974aacca8ae8f0693feede838] ASoC: SOF: amd: Drop hos=
t bridge ID from struct
# good: [8f969537149d672d40a0e75a83f39451a5402780] ASoC: amd: acp: acp63: U=
se AMD_NODE
# good: [c893ee3f95f16fcb98da934d61483d0b7d8ed568] x86/amd_node: Add a smn_=
read_register() helper
# good: [d1a09c610027e446ed30c21f61c2f2443bf92a3f] MAINTAINERS: adjust the =
file entry in SPI OFFLOAD
# good: [a78f244a9150da0878a37a1b59fb0608b1ccfb9d] ASoC: SOF: imx: Fix erro=
r code in probe()
# good: [b20be2c77ce5341ded1a2d8aec119f6dca8ef1ad] ASoC: SOF: imx: Fix an I=
S_ERR() vs NULL bug in imx_parse_ioremap_memory()
# good: [5d9fca12f54d3e25e02521aa8f3ec5d53759b334] ASoC: amd: ps: fix incon=
sistent indenting warning in check_and_handle_sdw_dma_irq()
# good: [0770b7cc095e015af302f0758d3d85c7f17c719a] ASoC: tas2764: Random pa=
tches from the Asahi Linux
# good: [3f02dedf1566858736f351a8d4a3ce91375e48f1] ASoC: random cleanup
# good: [e0f421d73053eaeb441aa77054b75992705656c7] ASoC: SOF: ipc3: Use str=
_enabled_disabled() helper function
# good: [5c7e4c4da8586d2ef55a11a9f4df626b8ea9a146] ASoC: dt-bindings: wlf,w=
m8960: add 'port' property
# good: [783db6851c1821d8b983ffb12b99c279ff64f2ee] ASoC: ops: Enforce platf=
orm maximum on initial value
# good: [9dc016eaba3a70febcd1db5f1a0beeb7430166aa] ASoC: SOF: Intel: Don't =
import non-existing module namespace
# good: [9f25b6f2568d50c247a8e3b031a0a5caee8c17d2] ASoC: wm_hubs: Use str_e=
nable_disable() in wm_hubs_update_class_w()
# good: [e08fe24c34d37d00e84009f2fb4c35f5978041e6] ASoC: SOF: Intel: Use st=
r_enable_disable() helper
# good: [735049b801cf3d597752017385cfc8768ce44303] x86/amd_node, platform/x=
86/amd/hsmp: Have HSMP use SMN through AMD_NODE
# good: [7e1caa679686dde5c24d60b139f234568045758f] ASoC: soc-pcm: makes dpc=
m_dapm_stream_event() void
# good: [6b06755af6679fd7c98ebc017ac31c8a74127538] x86/amd_node: Add suppor=
t for debugfs access to SMN registers
# good: [1c3b5f37409682184669457a5bdf761268eafbe5] ASoC: tas2764: Power up/=
down amp on mute ops
# good: [f37f1748564ac51d32f7588bd7bfc99913ccab8e] ASoC: tas2764: Mark SW_R=
ESET as volatile
# good: [bebe0afb74514ae51f4f348b28326c658b02209d] x86/amd_node: Add SMN of=
fsets to exclusive region access
# good: [d64c4c3d1c578f98d70db1c5e2535b47adce9d07] ASoC: tas2764: Add reg d=
efaults for TAS2764_INT_CLK_CFG
# good: [42da18e62652b58ba5ecd1524c146b202cda9bb7] ASoC: soc-pcm: cleanup d=
pcm_fe_dai_do_trigger()
# good: [40b1f89a1691c4b7740bec2c868f1e4c60346353] ASoC: remove dpcm_proces=
s_paths()
# good: [3aebbcba4baaa81bc8c83f2229ed8e774cf40618] ASoC: soc-pcm: cleanup d=
pcm_dai_trigger_fe_be()
# good: [1248d29464cc682c2a1793cfc5d4ebeb374c6738] ASoC: soc-ops: makes snd=
_soc_read_signed() void
# good: [08a66f55f7246d477b19620a953476dfc02beefc] ASoC: tas2764: Wait for =
ramp-down after shutdown
# good: [238c863eb3d3c6ed58493bacfd1f4b36bdcfa92f] ASoC: soc-core: makes sn=
d_soc_set_dmi_name() local
# good: [257a060fe219bb0dcb98f12ce34f04eca6d08352] ASoC: remove update from=
 snd_soc_card
# good: [7f1186a8d738661b941b298fd6d1d5725ed71428] ASoC: soc-dai: check ret=
urn value at snd_soc_dai_set_tdm_slot()
# good: [11c1967f1a796bf2ff56a7118147f1d39d9f5ee0] ASoC: soc-pcm: no need t=
o check dpcm->fe on dpcm_be_connect()
# good: [0c4a06395156d16ea33e959fccea84e4cfec04c4] ASoC: soc-pcm: remove du=
plicate param from __soc_pcm_hw_params()
# good: [74e0fcbd705d4277267311f8f26a00bb8ce93820] gpiolib: add gpiod_multi=
_set_value_cansleep
# good: [994719ed6d81a6f4677875ab6730254c0bc484ea] ASoC: Intel: avs: Use st=
r_on_off() in avs_dsp_core_power()
# good: [ae575d2145d1a2c8bb5d2835d7d54751f3b0bace] ASoC: tegra: Remove the =
isomgr_bw APIs export
# good: [828c0aa63706410503526d0ee522b9ac3232c86b] ASoC: amd: ps: use switc=
h statements for acp pci revision id check
# good: [f22ba3561daa792dd138ed543e0bf48efe0b999c] ASoC: SOF: imx-common: s=
et sdev->pdata->hw_pdata after common is alloc'd
# good: [ad0fbcebb5f6e093d433a0873758a2778d747eb8] ASoC: adau1701: use gpio=
d_multi_set_value_cansleep
# good: [e957c96455e8f4c630d5e374312cad0633ca7e17] spi: offload: fix use af=
ter free
# good: [d795a052b0ddad3da83dda6ff522c1b1aaa4a525] spi: fix missing offload=
_flags doc
# good: [91931af18bd22437e08e2471f5484d6fbdd8ab93] gpiolib: add gpiod_multi=
_set_value_cansleep()
# good: [ff4d4158ef9143327a42f7be4298751cb0d1be69] spi: spi-offload-trigger=
-pwm: add extra headers
# good: [fcd7ace9a725ae034ff9f24cb94c9fe12a1f02da] spi: offload: types: inc=
lude linux/bits.h
# good: [21aa330fec31bb530a4ef6c9555fb157d0711112] ASoC: fsl_micfil: Add de=
cimation filter bypass mode support
# good: [ad1212a9cc24b740b2711014933fac6ace32aa2d] arm64: dts: rockchip: Ad=
d SPDIF on RK3588
# good: [f46eb2bfb878ce3345725252f77fa3ba36a0f087] spi: axi-spi-engine: add=
 offload support
# good: [c5528214c7c0a753c908a7b353309ba665985fb4] ASoC: codecs: wcd93xx-sd=
w: fix of_property_read_bool() warnings
# good: [e97d06cb4386af4e069a2dc713de70500538d0bd] ASoC: tscs454: Use str_e=
nable_disable() in pll_power_event()
# good: [d1541caab053cf94b114582a23b51a8cb90f4a46] Add SDCA DisCo parsing s=
upport
# good: [3c331bdeececb629669961a80c0f929301c088d2] Refactor imx drivers and=
 introduce support for
# good: [330cbb40bb3664a18a19760bd6dc6003d6624041] dt-bindings: ASoC: rockc=
hip: Add compatible for RK3588 SPDIF
# good: [447c98c1ca4a4b0d43be99f76c558c09956484f3] tools/power turbostat: A=
dd idle governor statistics reporting
# good: [5132681dcd96b2a8c357b6e5d93e9876924bb80b] tools/power turbostat: F=
ix names matching
# good: [005859a2cf7aa349fbbfe433ab1769b15c535b72] ASoC: amd: Add support f=
or ACP7.0 & ACP7.1
# good: [700a281905f2a4ccf6f3b2d3cd6985e034b4b021] spi: add offload TX/RX s=
treaming APIs
# good: [563e40153a56cbfae8721f9591022df5d930f939] ASoC: SOF: imx8: use IMX=
_SOF_* macros
# good: [629dd55cf77bd3a8f80049150d3c05fef6d3b468] ASoC: SDCA: Minor format=
ting and naming tweaks
# good: [651e0ed391b148f83afba0bfbd8a56e38e58c34d] ASoC: SOF: imx: introduc=
e more common structures and functions
# good: [07e3e514dd385300bd08da4a8df09240d272821e] ASoC: SOF: imx: merge im=
x8 and imx8ulp drivers
# good: [d7231be4b4657e5f922a4c6dc11e8dffc71fee87] spi: offload: add suppor=
t for hardware triggers
# good: [f98d42000216677d177384f202ff1cc896a7395f] ASoC: Intel: soc-acpi-in=
tel-ptl-match typo fixups
# good: [645753d01356ff1a756812f1c69c53eb5c9081cd] ASoC: SOF: imx8: use com=
mon imx chip interface
# good: [5a19e1985d014fab9892348f6175a19143cec810] spi: axi-spi-engine: imp=
lement offload support
# good: [896530b7b0c08ee8b3296d5f012bfe1b0a979b86] ASoC: SOF: imx: merge im=
x8 and imx8m drivers
# good: [ebb398ae1e052c4245b7bcea679fe073111db2ce] spi: offload-trigger: ad=
d PWM trigger driver
# good: [5c93b20f6de4478e1fbcfb38eb46738bca74180e] ASoC: SDCA: Add support =
for IT/OT Entity properties
# good: [f87c2a275033120e15213f3d65234d98e726c4b7] ASoC: SDCA: Add Channel =
Cluster parsing
# good: [19f6748abbab8523a7b32a5e371e39d4d8d4aba5] ASoC: SDCA: Parse initia=
lization write table
# good: [42b144cb6a2d87385fa0b124c975d6cf1e3ec630] ASoC: SDCA: Add SDCA Con=
trol parsing
# good: [8e02d188698851436f76038ea998b726193d1b10] spi: add basic support f=
or SPI offloading
# good: [e1101373df5cd7672d988bb4e9cdd5eb97003165] spi: dt-bindings: axi-sp=
i-engine: add SPI offload properties
# good: [9ee6d50ae4b0fe14ed70a5265a05874d41e10848] ASoC: SDCA: Add support =
for Entity 0
# good: [9da195880f167ab7c2d595388decf783c9920121] ASoC: SDCA: Add support =
for PDE Entity properties
# good: [64fb5af1d1bbcf1b808e9bb092b22fa1b691ae63] ASoC: SDCA: Add parsing =
for Control range structures
# good: [45e02edd8422b6c4a511f38403dbd805cd139733] ASoC: SOF: imx8: drop un=
needed/unused macros/header includes
# good: [e80b8e5c53c30df1cba45258d10b04872b7eea67] ASoC: SDCA: Add support =
for clock Entity properties
# good: [6cf5df1040ba0694aea6a5edc6f31811a442ea36] ASoC: SOF: imx: add driv=
er for the imx95 chip
# good: [83f37ba7b76ab17e029ab4127ec64ccccce64c00] dt-bindings: trigger-sou=
rce: add generic PWM trigger source
# good: [996bf834d0b61cb5a1389356c1ed7db1230139d7] ASoC: SDCA: Add code to =
parse Function information
# good: [43d6140cedad9f031b47dfde6f85856e007b3f04] ASoC: amd: ps: refactor =
soundwire dma interrupts enable/disable sequence
# good: [491628388005a26c02d6827e649284357daec213] ASoC: amd: ps: add callb=
ack functions for acp pci driver pm ops
# good: [187150671d83324f1ca56f7ab5e00f16a3b9f2a9] ASoC: amd: acp: add RT71=
1, RT714 & RT1316 support for ACP7.0 platform
# good: [1c35755f46423150e19ff57448786b4bb48fdb46] ASoC: amd: ps: implement=
 function to restore dma config for ACP7.0 platform
# good: [fcb754602724fa2a1d0db72f13ddc3ef0306f911] ASoC: amd: ps: store acp=
 revision id in SoundWire dma driver private data
# good: [d0252b0b945ec67fd09fc764dcadf445fb7757ee] ASoC: amd: acp: amd-acp7=
0-acpi-match: Add rt722 support
# good: [31e3100d5e1fe69f944f84867be0cbfa5fd380c8] ASoC: amd: acp: amd-acp7=
0-acpi-match: Add RT1320 & RT722 combination soundwire machine
# good: [0b6914a0121b4c9fc8f575b60a5dd43b74612908] ASoC: amd: ps: add sound=
wire dma interrupts handling for ACP7.0 platform
# good: [0eb8f83c055cb3461734710d1b1ce2dd4f01806e] ASoC: amd: ps: update mo=
dule description
# good: [852c0b7204ded184924c41ab99b2ac7a70ad4dab] ASoC: Intel: soc-acpi-in=
tel-ptl-match: add rt713_vb_l2_rt1320_l13
# good: [4b36a47e2d989b98953dbfb1e97da0f0169f5086] ASoC: amd: ps: use macro=
 for ACP6.3 pci revision id
# good: [3898b189079c85735f57759b0d407518c01c745e] ASoC: amd: ps: add sound=
wire wake interrupt handling
# good: [c878d5c1a525b88807d9d79888fe8340bcbf1aa3] ASoC: amd: ps: add ACP7.=
0 & ACP7.1 specific soundwire dma driver changes
# good: [4bb5b6f13fd83b32c8a93fbd399e7558415d1ce0] ASoC: amd: amd_sdw: Add =
quirks for Dell SKU's
# good: [fde277dbcf53be685d0b9976d636366c80a74da8] ASoC: amd: ps: add pm op=
s related hw_ops for ACP7.0 & ACP7.1 platforms
# good: [91f505dc3a94c04421a2a51e8c40acf7ea67ecbc] ASoC: Intel: soc-acpi-in=
tel-ptl-match: add rt712_vb + rt1320 support
# good: [e2ceac2f323625632f12dd5333092976298a0cde] ASoC: amd: ps: rename st=
ructure names, variable and other macros
# good: [552f66c40134542f15d4302837e7d581a0b8e217] ASoC: amd: update Pink S=
ardine platform Kconfig description
# good: [638ad2bdb2f994c8bd99cc40e0c4796a8617ccf3] ASoC: amd: acp: add mach=
ine driver changes for ACP7.0 and ACP7.1 platforms
# good: [7c0ea26c57b0bb72d503fe27d6533f5addc5e3a3] ASoC: amd: ps: add pci d=
river hw_ops for ACP7.0 & ACP7.1 variants
# good: [0a27b2d7a224326fab543ca586d501fe1857b655] ASoC: amd: ps: add sound=
wire dma irq thread callback
# good: [4516be370ced14c4fb454fd6cc016e47bffe109e] ASoC: amd: ps: refactor =
soundwire dma interrupt handling
# good: [6547577e94ae3d9f8ff30d3267fe7ec394e3b20d] ASoC: amd: ps: add callb=
ack to read acp pin configuration
# good: [605aab3b3ca83f58681841b2dd16d4a7baefde6c] ASoC: amd: ps: rename ac=
p_restore_sdw_dma_config() function
# good: [0fa0843db17ccd427fc7a23d313aafa88fc89e04] ASoC: amd: ps: refactor =
soundwire dma driver code
# good: [db746fff89a14419379226ce0df8b94f472cf38c] ASoC: amd: ps: add acp p=
ci driver hw_ops for acp6.3 platform
# good: [f1e91acacf86fb2cd7478af490326cb9aa63e8ae] ASoC: amd: ps: update fi=
le description and copyright year
# good: [a23ff143804d3b8c27157ffa19e48b4e22939115] ASoC: Intel: avs: Add su=
pport for MalibouLake
# good: [f0703ce627a25b4a1307d8a92cfd6d6bf7e27e7a] ASoC: cpcap: Implement j=
ack headset detection
# good: [46ab7d80ed4f378e02cb249bd49a76026a2d683f] Add static channel mappi=
ng between soundwire master
# good: [f2d161e5804d8da070988624b9edd179ef31b478] ASoC: and adn use snd_so=
c_ret()
# good: [6b8f162bd3fa82c3c1b3653100d04172c1dbd8a5] ASoC: SOF: Improve the s=
pcm and ipc4 copier prints
# good: [153dbf4adad0082d030c30d20541df2b1af52db6] regmap: irq: Use one way=
 of setting all bits in the register
# good: [96dd187c93afe0ae0535276a92ed488759ace5a2] This is continued work o=
n Samsung S9(SM-9600)
# good: [cb161c333927142818d6bf22a4da2b023fb2b8c9] ASoC: tas2781: Switch to=
 use %ptTsr
# good: [583348bd65ceaf4a5067a6267dd236929e1b4b37] ASoC: SOF: ipc4-topology=
: Improve the information in prepare_copier prints
# good: [5ea46b4360791345bd0bf4c7bf8fff5151374ea1] ASoC: SOF: ipc4-pcm: Mov=
e out be_rate initialization from for loop in fixup
# good: [0e9a970d7b2cb98d741bc0e32ad8c8f30c009c63] ASoC: qcom: sdw: Add get=
 and set channel maps support from codec to cpu dais
# good: [d959fed68e4d45ee80cbdd62976bda8da52ab8b1] media: qcom: camss: Add =
callback API for RUP update and buf done
# good: [2466b62268c020606d20b45e007c166399e639ee] ASoC: dapm: unexport dap=
m_mark_endpoints_dirty()
# good: [0a7c85b516830c0bb088b0bdb2f2c50c76fc531a] regulator: ad5398: Fix i=
ncorrect power down bit mask
# good: [c06c4f7cbea1d8dc71485bfddef2849a1b721e67] ASoC: codecs: wcd937x: A=
dd static channel mapping support in wcd937x-sdw
# good: [ecfcee245cc99def0f6bf84ac75ac372f8ab65eb] ASoC: dapm: unexport snd=
_soc_dapm_init()
# good: [4c7518062d638837cea915e0ffe30f846780639a] ASoC: SOF: ipc4: Add sup=
port for split firmware releases
# good: [3f78762d17701f0435ad958b2821dc3243ff34b3] ASoC: dapm: unexport snd=
_soc_dapm_update_dai()
# good: [943116ba2a6ab472e8ad2d1e57a3f10f13485cc2] ASoC: add common snd_soc=
_ret() and use it
# good: [062b7ef6b103dcbcb3c084e8ace8e74e260b2346] ASoC: soc-utils: care -E=
OPNOTSUPP on snd_soc_ret()
# good: [9bbbf33a5ab84c0f3643f43350b0f473b60af5b8] spi: gpio: Enable a sing=
le always-selected device
# good: [a0ef5b4b101424b8a666ed56bf1717dafe2d37f5] ASoC: simple-card: use s=
nd_soc_ret()
# good: [2d7395b23dbf4c2d60be49b73e4c4705fc446662] ASoC: simple-card-utils:=
 use snd_soc_ret()
# good: [be61cd4242e4a53f5cf989ee7573121d041444bc] ASoC: soc-pcm: use snd_s=
oc_ret()
# good: [72826381215e2f9d2bd2f32f63f76a80942b7fdf] ASoC: dt-bindings: wcd93=
7x-sdw: Add static channel mapping support
# good: [7796c97df6b1b2206681a07f3c80f6023a6593d5] soundwire: qcom: Add set=
_channel_map api support
# good: [78e66dd5f32a1a8e5ee6decadd4e4dffa7d2c40d] ASoC: mediatek: mt8186: =
Remove unused mt8186_afe_(suspend|resume)_clock
# good: [860693187c597645b28a421d8acb26428b8afd3f] ASoC: SOF: pcm: Add snd_=
sof_pcm specific wrappers for dev_dbg() and dev_err()
# good: [169ec0a541aac8afb215ab591b0fd53276686014] ASoC: SOF: Relocate and =
rework functionality for PCM stream freeing
# good: [8d83282e53185ec257a4ce08812e8fabee2c7212] ASoC: audio-graph-card2:=
 use snd_soc_ret()
# good: [4d2ea16576c8aa1437048cf436bff85653f139fe] ASoC: SOF: pcm: Move per=
iod/buffer configuration print after platform open
# good: [74a0ca4c7f19f1b273d665b3b53f7ae8af879658] ASoC: audio-graph-card: =
use snd_soc_ret()
# good: [b3d993c7566fed1c027c5c18f3ef482ba8e6307a] ASoC: amd: acp: Use str_=
low_high() helper function
# good: [215705db51eb23052c73126d2efb6acbc2db0424] spi: Replace custom fsle=
ep() implementation
# good: [185ac20a7b055e025027d303b63dab456b4f5d5e] ASoC: rt722: get lane ma=
pping property
# good: [c108905a7423d44237d17374f845fc5bb9cb9728] spi: gpio: Remove stale =
documentation part
# good: [6603c5133daadbb3277fbd93be0d0d5b8ec928e8] ASoC: dt-bindings: atmel=
,at91-ssc: Convert to YAML format
# good: [3f75771987f32a9f512c8944e70e343f8c6d71c1] ASoC: SOF: mediatek: Use=
 str_on_off() helper function
# good: [678681828bf4abfd3c31f36390d2097682141d11] ASoC: dmic: Add DSD big =
endian format support
# good: [25fac20edd09b60651eabcc57c187b1277f43d08] spi: gpio: Support a sin=
gle always-selected device
# good: [e27c125040b1e1f26d910b46daabbe55e67fdf3b] ASoC: codecs: wcd934x: u=
se wcd934x binding header
# good: [8478dadc8148af311c3d43d4867cfb6632686ede] ASoC: dt-bindings: Add b=
indings for WCD934x DAIs
# good: [e3cd85963a20d2b92e77046a8d9f0777815f1f71] x86/mtrr: Use str_enable=
d_disabled() helper in print_mtrr_state()
# good: [652ffad172d089acb1a20e5fde1b66e687832b06] spi: fsi: Batch TX opera=
tions
# good: [8418753187ba216f8931432dd8a6ee2f23977ecd] staging: gpib: Make stat=
ic, reduce fwd declarations
# good: [b2f10aa2eb18d289e48097e0ed973e714322175b] x86/entry: Add __init to=
 ia32_emulation_override_cmdline()
# good: [fb6ec1d27608c008bfe1ab0dfec3720990eb2451] ASoC: mediatek: mt6358: =
Remove unused functions
# good: [4a91fe4c0d683c56044579fb263c660f5d18efac] ASoC: tegra: Add interco=
nnect support
# good: [e92f042642aed6f6206caace892d9df2d0166841] ASoC: codecs: pcm3168a: =
Relax probing conditions
# good: [1a4a5a752fcd60797ed2cb7c06253c6433d13f63] ASoC: soc-ops: remove so=
c-dpcm.h
# good: [6eab7034579917f207ca6d8e3f4e11e85e0ab7d5] ASoC: soc-core: Stop usi=
ng of_property_read_bool() for non-boolean properties
# good: [78683c25c80e54bf3e8015fdfb8cba2fcd03daa5] RDMA/mana_ib: Allow regi=
stration of DMA-mapped memory in PDs
# good: [cbe37a4d2b3c25d2e2a94097e09b6d87461b8833] ASoC: Intel: avs: Config=
ure basefw on TGL-based platforms
# good: [79ebb596201c86712fe38b0ef73d25d07b932664] ASoC: Intel: avs: Add pc=
m3168a machine board
# good: [7d92a38d67e5d937b64b20aa4fd14451ee1772f3] ASoC: codecs: pcm3168a: =
Allow for 24-bit in provider mode
# good: [f0173cbe7fa79eafbdf32eed32337209f84ddacd] ASoC: Intel: avs: New ga=
teway configuration mechanism
# good: [e995c51903384be1c7aead246dc30cb5244179ac] ASoC: Intel: avs: Move D=
SP-boot steps into individual functions
# good: [320155a61f7fc810a915644e9e2a451bdcea90b1] ASoC: Intel: avs: Remove=
 unused gateway configuration code
# good: [26a756fc10fac6f133ef47f12362a39769dfe24d] spi: zynqmp-gqspi: Clean=
 up the driver a bit
# good: [856366dc924a9561dae39f252b45dfd6cc6895ce] ALSA: hda: Select avs-dr=
iver by default on MBL
# good: [299ce4beaf714abe76e3ad106f2e745748f693e9] ASoC: rt722-sdca: Make u=
se of new expanded MBQ regmap
# good: [a05143a8f713d9ae6abc41141dac52c66fca8b06] ASoC: SOF: topology: Use=
 krealloc_array() to replace krealloc()
# good: [3c32a4386909e8023b3c49253fec33d267be16bb] regulator: Add device tr=
ee support to AD5398
# good: [f9a5c4b6afc79073491acdab7f1e943ee3a19fbb] ASoC: rt722-sdca: Add so=
me missing readable registers
# good: [4343af66b8e1df1d3a2e6f1f8612506cb45b2afd] ASoC: Intel: avs: Add WH=
M module support
# good: [dc561ab16d8be9cbe8f07a49a7b2f5428fbcfeea] ASoC: codecs: pcm3168a: =
Add ACPI match table
# good: [b9fb91692af881736f8fa1741fa0dbadf07d99ee] ASoC: Intel: avs: pcm316=
8a board selection
# good: [c9e9aa80022c6db71bc097a621a6145f39aa0ade] ASoC: mediatek: Remove u=
nused mtk_memif_set_rate
# good: [9b32c86e40da792544c53076f5ec43f115e56687] spi: zynqmp-gqspi: Clean=
 up fillgenfifo
# good: [d61009bd578ee7381a3cce5c506190ecb8f9d6e8] spi: zynqmp-gqspi: Refor=
mat long line
# good: [f5aab0438ef17f01c5ecd25e61ae6a03f82a4586] regulator: pca9450: Fix =
enable register for LDO5
# good: [d2ead60d853189f8e5ec6b301fac1e60e0b4b47d] spi: zynqmp-gqspi: Add h=
elpers for enabling/disabling DMA
# good: [c1ac98492d1584d31f335d233a5cd7a4d4116e5a] spi: realtek-rtl-snand: =
Drop unneeded assignment for cache_type
# good: [ba54629287f58b22c1d37f80f1875373e4b51ea6] spi: zynqmp-gqspi: Add s=
ome more debug prints
# good: [89785306453ce6d949e783f6936821a0b7649ee2] spi: zynqmp-gqspi: Alway=
s acknowledge interrupts
# good: [c73be62caabbec6629689c705aea65e5ce364d5d] Revert "regulator: pca94=
50: Add SD_VSEL GPIO for LDO5"
# good: [b5ec74c2aec76fbdff9bc16951455602e11902bf] arm64: dts: imx8mp-skov-=
reva: Use hardware signal for SD card VSELECT
# good: [7ed1b265021dd13ce5619501b388e489ddc8e204] ASoC: cpcap: Implement j=
ack detection
# good: [5a6a461079decea452fdcae955bccecf92e07e97] regulator: ad5398: Add d=
evice tree support
# good: [19d022d67d7353f0e6e9ba255435d3de93862ac4] regulator: ad5398: chang=
e enable bit name to improve readibility
# good: [5b4288792ff246cf2bda0c81cebcc02d1f631ca3] ASoC: cpcap: Implement .=
set_bias_level
# good: [f9cbf56b0a1966d977df87d15a5bdbff2c342062] dt-bindings: regulator: =
pca9450: Add properties for handling LDO5
# good: [995cf0e014b0144edf1125668a97c252c5ab775e] regmap: Reorder 'struct =
regmap'
# good: [3ce6f4f943ddd9edc03e450a2a0d89cb025b165b] regulator: pca9450: Fix =
control register for LDO5
# good: [f76ad354146d773d4cad436bb9004d230bffd6dd] Merge branch 'for-6.14/s=
elftests-dmesg' into for-next
# good: [02d4a97ce30c0494ce6a614cd54d583caa0f8016] dt-bindings: mfd: motoro=
la-cpcap: Document audio-codec interrupts
# good: [5e36be5973b6ac66198220365bffb7a3641038f9] Merge branch 'for-6.4/co=
re' into for-next
# good: [26d6fd81916e62d2b0568d9756e5f9c33f0f9b7a] drm/connector: make mode=
_valid take a const struct drm_display_mode
# good: [7e17e80c3a7eb2734795f66ba946f933412d597f] Merge branch 'for-6.14/s=
tack-order' into for-next
git bisect start 'eea255893718268e1ab852fb52f70c613d109b99' '97654dc13f139e=
a726042711a4943f424c5d5b83' '5cd09a324588b4554c9ed89cef34fa502a097d16' '8a7=
e7a03e3c53cd9abbbf233899cc2e05b2c6ec0' '1ec3f1dc215d4b3d3679ecdc4a549d4e82b=
3a609' '69823334200029767de785d30acf74e4872a11d3' 'db91ad81a2545eb82aa47d03=
06bc3e1adb05e336' 'a8fed0bddf8fa239fc71dc5c035d2e078c597369' '0d2d276f53ea3=
ba1686619cde503d9748f58a834' '8aeb7d2c3fc315e629d252cd601598a5af74bbb0' '4a=
43c3241ec3465a501825ecaf051e5a1d85a60b' '80416226920c21e806f93bd0930d67557f=
41600f' 'd3321a20b5111a66f3e68798959a347acfccbd44' 'eea84a7f0cdb693c261a7cf=
84bd4b3d81479c9a6' '0978e8207b61ac6d51280e5d28ccfff75d653363' 'a0db661e7d8e=
084e9cf3b9cdca7c6e4e66f2e849' '02a838b01b8e7c00e2efe78db06fff356a112dec' '5=
d5eceb9bb1050774dadc6919a258729f276fd00' '3707fd9c383fc7ae19733a3ad2e5a82bf=
86370a0' '7a2ff0510c51462c0a979f5006d375a2b23d46e9' '269b844239149a9bbaba66=
518db99ebb06554a15' '7dfc9bdde9fa20cf1ac5cbea97b0446622ca74c7' '2c2eadd07e7=
47059ccd65e68cd1d1b23ca96b072' 'c6141ba0110f98266106699aca071fed025c3d64' '=
a1462fb8b5dd1018e3477a6861822d75c6a59449' '1ff07522690d2c2b67343099d2d046e8=
8f71cddb' 'ffe450cb6bce16eb15f6bf90b85b7e5f9bfbc1e3' '65e246d33dede0008f281=
d3d09b7695bef2d18eb' 'c7a6a74f847923bb726029b85a3fd0e05e9fbb04' '02467341e3=
577836648753a9e9a5c196f08187da' '438405704eec45c06be9adc94eb5f94855412790' =
'8b36447c9ae102539d82d6278971b23b20d87629' 'e1a0657c6d943528ef58671594ca7e5=
b17db5394' '7172d9ae29afd00c8ee9a8e3a4eba4cea5d5e403' 'b92bc4d6e21f1802a399=
75e3c7cc4f76f591d46f' 'de22dc76e11d1291d4f50b73dbbaa158ba9d6acd' '6db630902=
72768785e6bb4a3afa16650c1e96c54' '426aae69373fb149e5bbe1d5fa18299d38414f22'=
 'ee3cce59b1cecad7edd2022a443c8607faa9a4ad' '2cb6290a24f74f1c4a1b4cbd311ddd=
50a2c6046a' 'd6c08418955a7d88bd5fe18787456264c4408e22' '24056de9976dfc33801=
d2574c1672d91f840277a' '56e8bbb7a0d1b15a1af87fc7d6a73469f6ed4bd2' '0a22454a=
b2eca530702b2689858909b608953703' '5fac6c2785f95ddd73db33289dcd3cd5a68be226=
' 'c095b7a27529d1d18b3b36a47f77a1419f0de939' '5c06f7f3d8374df1cec3b353306a4=
d1032a60f44' 'b19d340d5d08c5940ce612c2a1b5fe3a8a401f9d' '1d251a7adc5b720a71=
641c758a45b8a119971d80' '8243a49145e59f19032b86b20d8906f05e31bdcc' '79c080c=
75cdd0a5ba38be039f6f9bb66ec53b0c4' 'da9146c19b1774926148ff271c4a3dc8d7891b1=
8' 'c4b2d9643a06a5326a778c4d77d6fa60e0f3d6b1' '516493232a9b80dd4f4f6b078541=
cfad00973dbb' 'bf19467b8512f855bdfae59ae78d326b1f434443' 'c951b20766f019a26=
3b3547b07627be52fff87b4' '7c5b07b497eab8eba75cf5da00cba493216dfc12' 'aecdaa=
84adafb086b5b2939898d781bd63d6fe2e' 'b2b6913394488e031ee3d726f247b1c967057b=
40' '1743dbb45b2cbe5500068900794a355a7e0dd853' '98413be56faa1c12494f43e7f77=
746763fa41c4a' '9e6e7e088cb78ce58ea442106b1f29cd7b6ff76e' '9bb7d7452363fc47=
0b76766b0a6356807e752795' '17ec58ac3c08c5c43bbdf5b08020fa4188a3009a' 'c01a7=
4844b74c584160d5253f794bbd2af015bec' 'e33d0569d7a1d041e37fb93094e7080785653=
1c2' '836d2924c05edb06e32eeede8bc12c4c96da0b3d' 'd8c808af2a9bf731f72fcb772c=
f22886c6d00d99' '1af0148c3f871e55a6c4adf544af77a19fd17671' 'd2f277bf8aaed8c=
5307ab998b2de4346bed6e884' 'db9912ce99c346c948c8fa774c0afc7d80d0ec20' 'f0bd=
6cb02505eca6adbe2e3ad3445a2420637c19' '0808c1ab8d1a1222194d830870f6b2b47220=
b1d7' '6dd61011a67e35b8d5f3b94193ed66d0c19ba425' '7c0572197faf3b6d6b2727145=
5e76ac8ba84c43f' 'cfb91be8f9c8e54e517a9a539012309101abcac5' '2c4a2b5d084b06=
e1a9fd2e85866b51f6118dd254' 'bcb896a69864aec4dd0251732a380bcdbeff8c51' 'cb1=
ebf6e20371208c49d59615bf4b46d92991fc4' 'c709a876b7de676d49b00b624b37d208e45=
2cc7e' '8410a099c88d1d720c9780b0ed716e544ea5a6d2' 'b15ea10972a1b4db23f74950=
03fccc6fe59e44bd' '291b4eb984792fcc0bd3dec9ad9a69c3c6988951' '9ef6a439bc987=
753b7e5af5a926f05debe82bd1c' 'f5617b647c8597e2437b3899f520fdf65e0f277a' '6d=
41096d7df609992479d6a3a43bc60e21b8e165' 'd542f5bfa3e4e16aac6141abdd44bb8a2a=
6f0761' 'b1f5886cca25a6957b5541031376e2c06c5bd621' '79b8a705e26c08f8f09dd55=
f1dd56f2375973d2d' '27f5e88fdc8ab577dbff389085ae6ad41e994ae7' '1455b3857ca2=
d05966005f7172210f6bd00048c3' '3d5f026256d985e8b81e7657a5430a9ff14e651c' 'f=
d6bc2ba410bf7828dc2104bf78b51ccbb216c40' '25baeacd9c6307830e2ed9f586f81fc23=
d4d1002' '862123a0a41647bd130a2d0edefc76a52dc8b8f8' '69e35d9bfd6ba2837fe18b=
ebf97ea747ceb110d5' '2d2223d742d968fec77ed056db9f158e7cb3ca94' 'edca7ad57c5=
0483ec81ab5b74ff1d71dca62e5cb' '06d07a4f5b98c71c696fa8f8718050b656ab99ba' '=
697c58941c0a0d1a5ea3f323cf0231018d3ec4b3' '294a60e5e9830045c161181286d44ce6=
69f88833' 'bed97e35786a7d0141d1ecaaace03c46b5435d75' 'ccf2a77a5d1504ca95c1a=
e5f37ed184e62dcd2f2' '0d4291fa3a8945d97d26a6bac8a4068f116f2885' '3f97e52562=
dd1ad041f63c910a746eab695f40c1' 'c8c1ab2c5cb797fe455aa18b4ab7bf39897627f6' =
'99239dc5147ea4678e871e5c9d068a36f154558b' '38cc5b0bed6c57367dca3725d01857f=
a0876899a' 'feb849404a8b677aa6760d1539acf597e4574337' '522f5021cfb5a74e9b7a=
a3cbf365471f7a564c0a' '68084db5e7a5eb1e4901e2158565cfc59873756d' '2725c0187=
85d52286dd5b4ff7e087d2ff455a1a8' '35492f84fbd6d790ad7f93bffaaa6823890c103a'=
 'eeb25b3ca1ef57d57906295d829febbd30cf4d8d' '521c04c6e32ac110d942fa0e11bea4=
b91cc3241d' '597acf1a04bede55e3ad8a7922bba286c11112d3' '93b1fefd8b1a004c6c8=
f8c92085e7bfb694dfe98' 'abcb9a1fd89144536f3ef604f700e94424867366' 'b73c2719=
c951868efc15181269a3caeb99157f29' '29664312a75e47f989ad32e43682746d8681a02b=
' 'a02c42d41af7d66db71ca43c52531c3253ebe35e' '9c914ef3b876a6f6c0059b4f4323f=
c1b76fa05e4' 'c6472392301fc15a09d5435f1f89421270aed81c' '7370a8fe5bd2110426=
10ec200dcc83de5ccc50cd' 'd4ee06219f2fffb71e2a23fc5060fdd3c7bb2cf7' 'cc49a35=
ab19565c5eaef070755b6fba235f9d05a' '74da545ec6a8b41de96b4c350bb59dfe45c0d82=
2' '04ea3e0d2e10642f0a0199081e9aa8fd5e1bbea6' '7d73a1beaa9428ed4da7786725fc=
b1a20fd371ab' '541e0b4947a92f4bf1d60ef7e55f0a254d9c41a0' '9002421ebb1409e2f=
47062722aad598b561cf9eb' '5fee78e517ce0765def9387659fc56a1d5532c60' '7304d1=
909080ef0c9da703500a97f46c98393fcd' '0526b0b88c3092e38ba2d05f480b66bd5a1e10=
04' '4586b056956995754e95456312b2a9ce36c8de21' '6575dd53217ee5686d48a35f484=
15b113518d2a9' 'c80956630fa077646f971ff5d3e9452339742def' '22e5c40fda71d0b6=
cdf83af9418403808d5d06bd' '4994da5c7fea1ede9b71ae66e3b906ea56b9a929' '7f3ed=
7ea52f21d5b8ecc01a17fb8f7209d337cbe' 'b99c850bd41e8f6f142bb24c3c2485043b552=
621' 'cc8e22b6b1622f44654a9ce70c1285c15c1b8414' '0f68f56ab7be101fc949177774=
107769e63f13e9' '5dc6b4a351de9804932c4475a2c73c22c0b59369' 'e15abfa60107f97=
fd8297faad8cc3dc4eae0b5cc' '22bbcab0a2a100827a26833b7cab16ae8b1a3f9e' 'fb44=
bd4902cd5df526ad432015edcfaf163999e2' '6cc4d2c11537d66e9d4a7356a576f1bea6f4=
009f' '795aad6b179de4c3f68b18132bd183931d09c462' '711035c043b3a5116860b3a25=
d808572f70e1dc1' 'ed86f7b7e5f676c24ba0ddd86de6614a4b69a9e4' 'c417a7cf976eb8=
ecd8ebca439ec0cb0fe9ddc7ec' '47c59833c42a99bd27826f4f369bf4bb433c7ff9' '1c4=
18cf146380031b13b6fde02f944830e5b9155' 'ad3993c449637fcec1e05bd2b63c24d34cb=
82243' 'e2bcc61a4481c3de4747014895cef45d701956bf' '9b9cbc6b4fa312d963f4373e=
88b6e27106f2051a' '8f5ae83953335d9c4c8d1cb698b87cea1ac8aeca' '9aa85f433bb1f=
51b599278b29b3d6224ca5147cf' '48d5e50e4fe78bf9cc5b4eca72798d4507da62fb' 'dc=
946ef548aeeea258b040087b88c9b7fae5cb6d' 'e5f0c2ad987b494ab94bcb1331667d1892=
49f234' 'a06ef7754b8e6f45d78c0015c3edb2117945adfb' 'a212edb16ca0698c488c6ad=
fa6854224666c8cc1' 'f8ca280bf5c2a3fb08890bdd212a3f3c00589f87' '952b334dcfcf=
641a6290b876bdc226c23772287e' 'bb0b8a07192d86b291c5b13fb64ef984930f8ea6' '9=
0fd7bb1af1733685f0aece12dd7264d4ef68422' 'bc17eaf1b925595fb9f945ced5d70fe82=
ce11e78' '4869417f4a2b010e9ee00f611265f551a47e4f1a' '0c57e55719681412e87db7=
bb81b8255b43d6162f' '74f6e045d879414ae4c352dc7f4e8d438ea9d55d' '4d34ea67098=
94243d55ae6a6b63834851f9c5d6f' '1fca457c22a277ba47ae1bdd2a09d42926a5beed' '=
668db717850296122fa0e2aff471cd20a722e0c5' '0b74ed5533c87db1abe3967e3a370bc3=
046892c7' 'd17b39f6d3e635b039314726fbc66dcef286ed79' '7f15da9a55d3ba9f8c3af=
545246a4588102a38db' 'a018b6601c47e7d989f1fe5c175325f85dceb264' '9261d67d8b=
d2d9e787ceee8ff593f105bb3f5176' 'fad200733e5026b103ec2504ad3dfc2843216cc8' =
'85188e3bd7cb4141181f24a59f9057c38ffa37bf' 'e9d9a43e3f00b9313013b78d915a1f9=
7dd215bf5' 'dfdc0debf1b82354e301843f8cbd16eaf05a01c6' '67f2243f2b1f1936c4dc=
22897289f5815a0e224a' '0ad3a7d311f0e93f2e838b4e47a7da57c501d737' 'b9dde447d=
d27f1b3ca21e07da1d885fd342cfa62' 'e9ab4b38205a34fffe537b4db721458b5d07066e'=
 'c974655b0c7f82a760bd22d9ef9db281e765a9a2' '8450fa6b16e2f46f5b880e0b80d55a=
b9fc4524ca' 'd3a37a664ebe57471bd7ab2486dd3072a9c07378' '461deb4911f39e45575=
6cbc42928b12b04e82851' '2f8b07842e9e95122b848727ea73504a035e7c12' '92acd9f7=
409d2939e5fef8bde5ad527b9e525229' 'dee14c5b6d29886255c4a54599590d49fc1754be=
' '46dbe25747fca3d82e98dca488fa9be6b809d522' 'df95f0157ba1ea7b73b3f1db4abfd=
b4b05e0bfd9' '2f120ee8026ab9630dc7f93dd4bafdcd56c82056' '24684cc2060150afd7=
a1ea47c586f9c09330633c' 'ed4bef1d52ce0d6c96a86b6a470d6777034c564c' '941abe6=
7e176a3ddbe59cd4323b13f69515f6628' '5cfb2f62242b41e2b60cadf21b28ee43cf615ec=
2' 'b26c604a0dcef62e7c61bd1d560c63547c9bbfe8' '4be54b6bdafad7656fd85c1fa6b7=
bebb7700a3d2' '24a4302478118ff1caf39fb48809c0127f608664' '6de7c4def7a6bf967=
d6603f7e1abda5231ccc312' '4d20a35acef6fb8c42eff953a11759e94710ba8b' 'f12056=
56ef2334e860ced588e76dd88119394166' 'e759aeeb1d09147891e08682df3a70dfbd1572=
4a' '9c7cf29bdb11cfdd1b59d1ea1eb852245b26e93a' 'fc0a8ee9921f50ac23b32648467=
20d1d15be539e' '1a126668ab0946ebb7d1450742cd14775aa298fa' '2d5e9d40998b4414=
85376b8729c69073d8f2ab9d' '1b16920e651d11811ca4b3a5d92cfb3d817b1a14' 'dfc6b=
8ccb1bb8d591cd26571e554208fc4af7d0c' 'e42ec97657fa5ee40fd2358c973d273edd799=
9bd' '739f4f44dc42b866090297adc1f007ffcdefb602' '3c2e63a3a0efa8c52f9fd67f58=
a71af48957ca7a' '5f2d29942c82d229dbdafe4bd21585d1b67f31ee' 'b89d9d26fb6cbc9=
f6e0aae72a2a76b5d8e5f1023' 'd21e3b442ff6401511831ae1b8be11d530f063de' '4206=
63ae8fa2d70d2b824848763ca15bb5b2b585' '2920be2fabcb8010fefdf101d84fe0867730=
d925' '2281565db79b5fd6b539e73a28e73fc960ee34d4' '1b94f3874d61b34febd5ddf34=
82a90107dc80082' '9fde82ea39a7f52c23de366c8592d4805634f45c' '474cd6355413b2=
64087ddc66b1dbc6c7e59fb76f' '6f8ac982806a104e4e816e12279d85440b6f703f' '042=
ecb2ab2361f77b34a7d3c642bd378f6ecc73a' 'f61c11db0f598eed6dd35a2d700ca54c6c7=
4af4a' 'b3a3eda6cb30f21b818f40795468ff0a9f629990' '4042bb6e973aded1de6ce834=
36804a90181d6357' '739db0529c2a3ac5a0dc3e5a76a46ce80735dcfa' 'a3c86259f8a40=
2aa050fc5f3039f94c7872e4657' '1ef8b1c830a0b5a6600d803a8bbeb7179d3ca4da' 'b8=
65e0823cbffb747173b7dd4f4c8d82491d111f' '40213f8d5b498f5eb2f3297ee0f9c84d98=
737ee9' 'bd178280c7d967e87e217b51c0647a2bfdf5deec' 'ea38f63c4afdd5531fbd8f0=
f881594a94c4bd413' 'a1cadae42c9bc52cff24b22b0c4986be8d82ae16' '5a84cbb03094=
fd903ed79ca6c06e558821a69be4' '231bf041d425a086ec08231c98cf02b6fb16b169' 'e=
41ebb0a1f8bff63c8e333eec34ff64e748227d0' 'b50e5b9694e2a4355f2abeaa711dae519=
0661c27' '3165df2f130d567e6cf05d789ecc28810519e5f7' 'acac29fa62a8b738569a99=
da2f6458bc21aa55ae' '84f32702f3efe02c2622b9151d4e08c436249a8c' '7177a7a8e10=
d7722d0b9d4be4eea7dde014527b9' 'e23d68d7d3b35a44eb83d834b65cd28ca08844ec' '=
60143172c63daa49fef6eb9daa066fb7f1360bbe' 'f9ef0947ba848467e4dcca6b5ab3a4ff=
2e218df6' '0d41068ca151a6368ab4591c13e9a7a9fb92a56f' '30e03871146129acb75ad=
ac48405c203f5bdb3c2' 'b686559772d1baa28e2ad346d5a9932863d9523c' '0440f938aa=
cf54a3e7dc67cd898f76bbd371da49' 'e7795c17b82684afb9390b8788f781c07be1a368' =
'a859d2383f66002a442218bf5083faaa674bc4e4' '689e4d5fd8a76c676f04bc8916d78ca=
5db3130db' '5e9f822c9c683ae884fa5e71df41d1647b2876c6' 'c5c4ce6612bb25ce6d69=
36d8ade96fcba635da54' '6ddd1159825c516b8f64fda83177c161434141f5' '1455f0bad=
d6345b2606bafb32e719d252293ebcd' '579a20181cf2e9ddc2f1265ee4976a0e2631fd5d'=
 'c173b5ee81a25e8aafb21ccdb7ab457da7783bf1' '0bd862846e7f89910252cbef8718a7=
57950f1683' '3e706be02befae55b50b240d4360b5993f9879a8' 'd9d71a6e2d19a2f3cce=
bea0092b8ddc1e935886f' 'b26205e172ca035e327e49edb0c2611e5d2ede8d' '69aaab0e=
65e9bd7601740c1e14cc6de86dafb621' 'd0343fdb567dddaa74ac1b7b6994fd70100a0f6e=
' 'c143755d8cce31e770234732ff23134993b0550f' 'fd80df352ba1884ce2b62dd8d9495=
582308101b7' '79ed408b2402e8113aa5a298f3bb9088ede58f6c' '28c12866c22c2826cc=
bd8c82dc353f02ab2deea5' '825687c1662c53ecda991adf0ecfd8dd3d864043' 'e3f7caf=
74b795621252e3c25b4a9fb6888336ef1' 'be1e3607f29a5a182eaa70e3058aef32fd0cc4f=
8' 'a54a659f5cc25e3b23ab19af08d0b23488bd9f4e' 'a206376b425472c7c3a824f47a99=
67a4c97ae32c' '1d2e01d53a8ebfffb49e8cc656f8c85239121b26' '62142da241a08006f=
89b0620f7291e3a08c0a094' '7ed7065dfbbac1b5405a0c8029299847e408cf97' '1b8b6d=
d0c91b7db58e344f01781932458ac43da3' '55a1abd6e76ce91eb6049f32efec3a85066867=
48' '32fcd1b9c397ccca7fde2fcbcf4fc7e0ec8f34aa' 'dc64e1b9da22496b5867f90315a=
c406be041db15' 'bf1800073f4d55f08191b034c86b95881e99b6fd' 'b80fd34df2580f2c=
7a99e7188d68515bcf779714' '38399716e353776dca7f04dbae98a07af68f2880' '6542d=
b20caf4987b938ed8feec07d199779823f2' '390ebb24b3c3a95e109c28e14c2ec9fe3f0f8=
aaa' '63d93f4d0f38fbb95a55729fbd2cc4920743931c' 'f9d4f699751f0389e57f263821=
74334670b8276e' 'd909b8d13a13d0197877e16aaaa3b2fcbb502858' 'ef6a24c79d5047c=
029577113af43eddd1d0f1bd2' 'f00b3056843d14754ac1bab2106cf5599680f115' '2225=
4fca9bc7655801ad5f2af15729e44d28b85c' '3e7b375752b5e4de56e92dfb9c43309cd985=
b869' '7d87bde21c73731ddaf15e572020f80999c38ee3' '1c4749873bd0f769a47372636=
a428484e7035f59' 'c1e42ec04197ac013d049dde40d9c72cf543b5f6' '8fd0e127d8da85=
6e34391399df40b33af2b307e0' '5a09e179024e76afdf9ad3a6ae767b4e06884ea8' 'a5a=
3de8990f47f4c54ca5daeeea8ff7daa42f9de' '4c32ebcc8650ce506632a32136993c85537=
fb01a' '76e013152891a69dfe68a28706a51a7df9ed4c42' '10188a25c9b5944c0a912482=
011b484b7c2e22d4' '28feec15fa285e561c626b3490bc5a10f5d177c8' '0dffacbbf8d04=
4456d50c893adb9499775c489f4' '1877c3e7937fb2b9373ba263a4900448d50917b7' 'a4=
217a03686989c4a79530fe54fa17576aff7330' 'a9409fcb979eaff401837b955b234ca1ee=
05fdbd' '81eb3a2bd273b84fa9808e6b13b533f9c55e16eb' 'c321a4d705a31a50d758051=
6422aaa5b853e7602' '8c6ede5cc4226fd841f252d02ab0372cb92ee75c' '4c43a930e3e1=
65ca6890147a309508ccb6768faf' '758beab0252912395efb79f34095c5ae7e3e58b1' '1=
8311a766c587fc69b1806f1d5943305903b7e6e' '2fa56dae1a65e8124d417a31d7b02c37d=
f013817' '91b75129149429bb16927cda8b5642c04c59e6b0' '99e297cdd338b8a18c986e=
d4e088676579b7fe96' 'a103b833ac3806b816bc993cba77d0b17cf801f1' '10efa807929=
084a8a1c38655942a3bf83bce587a' '88e09306b7e0f8a9e9f9c729ac13ccd11ed9679d' '=
a21cad9312767d26b5257ce0662699bb202cdda1' 'b47834ee4485bbdcc6d36f086ff61c3e=
fd8870d4' '64899904d6103500ad01be7b763298dc939285ae' 'f3bfa0f07976a7996b6de=
dba21d2e0d164f08ce8' '2e2f89b184644f0e29f1ec0b4dcfd0361d2635cb' '42ae6e2559=
e63c2d4096b698cd47aaeb974436df' 'cb15abd47806b449e853caf43f41573c4c82fed3' =
'66d8e76e8e85a30fbf9809837e07e15a8c5ccb8b' 'c8d08464bce947ee060e0174a3f4e87=
503269d0c' 'f120cf33d2325fd95d063eccbff2e86ffc7f493a' '67ebf71236f2e7b0e4cf=
791700dcddc9eb8cf650' '40d05927830227f2a1701c61e8bbe65287a03490' 'e211adcf3=
6d0ccdd31af7398af4725a47d74b3d4' '135c6af1cac5465529469700d16c0c44b24ce317'=
 'a261d77fec147b9974aacca8ae8f0693feede838' '8f969537149d672d40a0e75a83f394=
51a5402780' 'c893ee3f95f16fcb98da934d61483d0b7d8ed568' 'd1a09c610027e446ed3=
0c21f61c2f2443bf92a3f' 'a78f244a9150da0878a37a1b59fb0608b1ccfb9d' 'b20be2c7=
7ce5341ded1a2d8aec119f6dca8ef1ad' '5d9fca12f54d3e25e02521aa8f3ec5d53759b334=
' '0770b7cc095e015af302f0758d3d85c7f17c719a' '3f02dedf1566858736f351a8d4a3c=
e91375e48f1' 'e0f421d73053eaeb441aa77054b75992705656c7' '5c7e4c4da8586d2ef5=
5a11a9f4df626b8ea9a146' '783db6851c1821d8b983ffb12b99c279ff64f2ee' '9dc016e=
aba3a70febcd1db5f1a0beeb7430166aa' '9f25b6f2568d50c247a8e3b031a0a5caee8c17d=
2' 'e08fe24c34d37d00e84009f2fb4c35f5978041e6' '735049b801cf3d597752017385cf=
c8768ce44303' '7e1caa679686dde5c24d60b139f234568045758f' '6b06755af6679fd7c=
98ebc017ac31c8a74127538' '1c3b5f37409682184669457a5bdf761268eafbe5' 'f37f17=
48564ac51d32f7588bd7bfc99913ccab8e' 'bebe0afb74514ae51f4f348b28326c658b0220=
9d' 'd64c4c3d1c578f98d70db1c5e2535b47adce9d07' '42da18e62652b58ba5ecd1524c1=
46b202cda9bb7' '40b1f89a1691c4b7740bec2c868f1e4c60346353' '3aebbcba4baaa81b=
c8c83f2229ed8e774cf40618' '1248d29464cc682c2a1793cfc5d4ebeb374c6738' '08a66=
f55f7246d477b19620a953476dfc02beefc' '238c863eb3d3c6ed58493bacfd1f4b36bdcfa=
92f' '257a060fe219bb0dcb98f12ce34f04eca6d08352' '7f1186a8d738661b941b298fd6=
d1d5725ed71428' '11c1967f1a796bf2ff56a7118147f1d39d9f5ee0' '0c4a06395156d16=
ea33e959fccea84e4cfec04c4' '74e0fcbd705d4277267311f8f26a00bb8ce93820' '9947=
19ed6d81a6f4677875ab6730254c0bc484ea' 'ae575d2145d1a2c8bb5d2835d7d54751f3b0=
bace' '828c0aa63706410503526d0ee522b9ac3232c86b' 'f22ba3561daa792dd138ed543=
e0bf48efe0b999c' 'ad0fbcebb5f6e093d433a0873758a2778d747eb8' 'e957c96455e8f4=
c630d5e374312cad0633ca7e17' 'd795a052b0ddad3da83dda6ff522c1b1aaa4a525' '919=
31af18bd22437e08e2471f5484d6fbdd8ab93' 'ff4d4158ef9143327a42f7be4298751cb0d=
1be69' 'fcd7ace9a725ae034ff9f24cb94c9fe12a1f02da' '21aa330fec31bb530a4ef6c9=
555fb157d0711112' 'ad1212a9cc24b740b2711014933fac6ace32aa2d' 'f46eb2bfb878c=
e3345725252f77fa3ba36a0f087' 'c5528214c7c0a753c908a7b353309ba665985fb4' 'e9=
7d06cb4386af4e069a2dc713de70500538d0bd' 'd1541caab053cf94b114582a23b51a8cb9=
0f4a46' '3c331bdeececb629669961a80c0f929301c088d2' '330cbb40bb3664a18a19760=
bd6dc6003d6624041' '447c98c1ca4a4b0d43be99f76c558c09956484f3' '5132681dcd96=
b2a8c357b6e5d93e9876924bb80b' '005859a2cf7aa349fbbfe433ab1769b15c535b72' '7=
00a281905f2a4ccf6f3b2d3cd6985e034b4b021' '563e40153a56cbfae8721f9591022df5d=
930f939' '629dd55cf77bd3a8f80049150d3c05fef6d3b468' '651e0ed391b148f83afba0=
bfbd8a56e38e58c34d' '07e3e514dd385300bd08da4a8df09240d272821e' 'd7231be4b46=
57e5f922a4c6dc11e8dffc71fee87' 'f98d42000216677d177384f202ff1cc896a7395f' '=
645753d01356ff1a756812f1c69c53eb5c9081cd' '5a19e1985d014fab9892348f6175a191=
43cec810' '896530b7b0c08ee8b3296d5f012bfe1b0a979b86' 'ebb398ae1e052c4245b7b=
cea679fe073111db2ce' '5c93b20f6de4478e1fbcfb38eb46738bca74180e' 'f87c2a2750=
33120e15213f3d65234d98e726c4b7' '19f6748abbab8523a7b32a5e371e39d4d8d4aba5' =
'42b144cb6a2d87385fa0b124c975d6cf1e3ec630' '8e02d188698851436f76038ea998b72=
6193d1b10' 'e1101373df5cd7672d988bb4e9cdd5eb97003165' '9ee6d50ae4b0fe14ed70=
a5265a05874d41e10848' '9da195880f167ab7c2d595388decf783c9920121' '64fb5af1d=
1bbcf1b808e9bb092b22fa1b691ae63' '45e02edd8422b6c4a511f38403dbd805cd139733'=
 'e80b8e5c53c30df1cba45258d10b04872b7eea67' '6cf5df1040ba0694aea6a5edc6f318=
11a442ea36' '83f37ba7b76ab17e029ab4127ec64ccccce64c00' '996bf834d0b61cb5a13=
89356c1ed7db1230139d7' '43d6140cedad9f031b47dfde6f85856e007b3f04' '49162838=
8005a26c02d6827e649284357daec213' '187150671d83324f1ca56f7ab5e00f16a3b9f2a9=
' '1c35755f46423150e19ff57448786b4bb48fdb46' 'fcb754602724fa2a1d0db72f13ddc=
3ef0306f911' 'd0252b0b945ec67fd09fc764dcadf445fb7757ee' '31e3100d5e1fe69f94=
4f84867be0cbfa5fd380c8' '0b6914a0121b4c9fc8f575b60a5dd43b74612908' '0eb8f83=
c055cb3461734710d1b1ce2dd4f01806e' '852c0b7204ded184924c41ab99b2ac7a70ad4da=
b' '4b36a47e2d989b98953dbfb1e97da0f0169f5086' '3898b189079c85735f57759b0d40=
7518c01c745e' 'c878d5c1a525b88807d9d79888fe8340bcbf1aa3' '4bb5b6f13fd83b32c=
8a93fbd399e7558415d1ce0' 'fde277dbcf53be685d0b9976d636366c80a74da8' '91f505=
dc3a94c04421a2a51e8c40acf7ea67ecbc' 'e2ceac2f323625632f12dd5333092976298a0c=
de' '552f66c40134542f15d4302837e7d581a0b8e217' '638ad2bdb2f994c8bd99cc40e0c=
4796a8617ccf3' '7c0ea26c57b0bb72d503fe27d6533f5addc5e3a3' '0a27b2d7a224326f=
ab543ca586d501fe1857b655' '4516be370ced14c4fb454fd6cc016e47bffe109e' '65475=
77e94ae3d9f8ff30d3267fe7ec394e3b20d' '605aab3b3ca83f58681841b2dd16d4a7baefd=
e6c' '0fa0843db17ccd427fc7a23d313aafa88fc89e04' 'db746fff89a14419379226ce0d=
f8b94f472cf38c' 'f1e91acacf86fb2cd7478af490326cb9aa63e8ae' 'a23ff143804d3b8=
c27157ffa19e48b4e22939115' 'f0703ce627a25b4a1307d8a92cfd6d6bf7e27e7a' '46ab=
7d80ed4f378e02cb249bd49a76026a2d683f' 'f2d161e5804d8da070988624b9edd179ef31=
b478' '6b8f162bd3fa82c3c1b3653100d04172c1dbd8a5' '153dbf4adad0082d030c30d20=
541df2b1af52db6' '96dd187c93afe0ae0535276a92ed488759ace5a2' 'cb161c33392714=
2818d6bf22a4da2b023fb2b8c9' '583348bd65ceaf4a5067a6267dd236929e1b4b37' '5ea=
46b4360791345bd0bf4c7bf8fff5151374ea1' '0e9a970d7b2cb98d741bc0e32ad8c8f30c0=
09c63' 'd959fed68e4d45ee80cbdd62976bda8da52ab8b1' '2466b62268c020606d20b45e=
007c166399e639ee' '0a7c85b516830c0bb088b0bdb2f2c50c76fc531a' 'c06c4f7cbea1d=
8dc71485bfddef2849a1b721e67' 'ecfcee245cc99def0f6bf84ac75ac372f8ab65eb' '4c=
7518062d638837cea915e0ffe30f846780639a' '3f78762d17701f0435ad958b2821dc3243=
ff34b3' '943116ba2a6ab472e8ad2d1e57a3f10f13485cc2' '062b7ef6b103dcbcb3c084e=
8ace8e74e260b2346' '9bbbf33a5ab84c0f3643f43350b0f473b60af5b8' 'a0ef5b4b1014=
24b8a666ed56bf1717dafe2d37f5' '2d7395b23dbf4c2d60be49b73e4c4705fc446662' 'b=
e61cd4242e4a53f5cf989ee7573121d041444bc' '72826381215e2f9d2bd2f32f63f76a809=
42b7fdf' '7796c97df6b1b2206681a07f3c80f6023a6593d5' '78e66dd5f32a1a8e5ee6de=
cadd4e4dffa7d2c40d' '860693187c597645b28a421d8acb26428b8afd3f' '169ec0a541a=
ac8afb215ab591b0fd53276686014' '8d83282e53185ec257a4ce08812e8fabee2c7212' '=
4d2ea16576c8aa1437048cf436bff85653f139fe' '74a0ca4c7f19f1b273d665b3b53f7ae8=
af879658' 'b3d993c7566fed1c027c5c18f3ef482ba8e6307a' '215705db51eb23052c731=
26d2efb6acbc2db0424' '185ac20a7b055e025027d303b63dab456b4f5d5e' 'c108905a74=
23d44237d17374f845fc5bb9cb9728' '6603c5133daadbb3277fbd93be0d0d5b8ec928e8' =
'3f75771987f32a9f512c8944e70e343f8c6d71c1' '678681828bf4abfd3c31f36390d2097=
682141d11' '25fac20edd09b60651eabcc57c187b1277f43d08' 'e27c125040b1e1f26d91=
0b46daabbe55e67fdf3b' '8478dadc8148af311c3d43d4867cfb6632686ede' 'e3cd85963=
a20d2b92e77046a8d9f0777815f1f71' '652ffad172d089acb1a20e5fde1b66e687832b06'=
 '8418753187ba216f8931432dd8a6ee2f23977ecd' 'b2f10aa2eb18d289e48097e0ed973e=
714322175b' 'fb6ec1d27608c008bfe1ab0dfec3720990eb2451' '4a91fe4c0d683c56044=
579fb263c660f5d18efac' 'e92f042642aed6f6206caace892d9df2d0166841' '1a4a5a75=
2fcd60797ed2cb7c06253c6433d13f63' '6eab7034579917f207ca6d8e3f4e11e85e0ab7d5=
' '78683c25c80e54bf3e8015fdfb8cba2fcd03daa5' 'cbe37a4d2b3c25d2e2a94097e09b6=
d87461b8833' '79ebb596201c86712fe38b0ef73d25d07b932664' '7d92a38d67e5d937b6=
4b20aa4fd14451ee1772f3' 'f0173cbe7fa79eafbdf32eed32337209f84ddacd' 'e995c51=
903384be1c7aead246dc30cb5244179ac' '320155a61f7fc810a915644e9e2a451bdcea90b=
1' '26a756fc10fac6f133ef47f12362a39769dfe24d' '856366dc924a9561dae39f252b45=
dfd6cc6895ce' '299ce4beaf714abe76e3ad106f2e745748f693e9' 'a05143a8f713d9ae6=
abc41141dac52c66fca8b06' '3c32a4386909e8023b3c49253fec33d267be16bb' 'f9a5c4=
b6afc79073491acdab7f1e943ee3a19fbb' '4343af66b8e1df1d3a2e6f1f8612506cb45b2a=
fd' 'dc561ab16d8be9cbe8f07a49a7b2f5428fbcfeea' 'b9fb91692af881736f8fa1741fa=
0dbadf07d99ee' 'c9e9aa80022c6db71bc097a621a6145f39aa0ade' '9b32c86e40da7925=
44c53076f5ec43f115e56687' 'd61009bd578ee7381a3cce5c506190ecb8f9d6e8' 'f5aab=
0438ef17f01c5ecd25e61ae6a03f82a4586' 'd2ead60d853189f8e5ec6b301fac1e60e0b4b=
47d' 'c1ac98492d1584d31f335d233a5cd7a4d4116e5a' 'ba54629287f58b22c1d37f80f1=
875373e4b51ea6' '89785306453ce6d949e783f6936821a0b7649ee2' 'c73be62caabbec6=
629689c705aea65e5ce364d5d' 'b5ec74c2aec76fbdff9bc16951455602e11902bf' '7ed1=
b265021dd13ce5619501b388e489ddc8e204' '5a6a461079decea452fdcae955bccecf92e0=
7e97' '19d022d67d7353f0e6e9ba255435d3de93862ac4' '5b4288792ff246cf2bda0c81c=
ebcc02d1f631ca3' 'f9cbf56b0a1966d977df87d15a5bdbff2c342062' '995cf0e014b014=
4edf1125668a97c252c5ab775e' '3ce6f4f943ddd9edc03e450a2a0d89cb025b165b' 'f76=
ad354146d773d4cad436bb9004d230bffd6dd' '02d4a97ce30c0494ce6a614cd54d583caa0=
f8016' '5e36be5973b6ac66198220365bffb7a3641038f9' '26d6fd81916e62d2b0568d97=
56e5f9c33f0f9b7a' '7e17e80c3a7eb2734795f66ba946f933412d597f'
# bad: [eea255893718268e1ab852fb52f70c613d109b99] Add linux-next specific f=
iles for 20250311
git bisect bad eea255893718268e1ab852fb52f70c613d109b99
# bad: [21b9e91ad0d8b7af26c672e73f02f786580d0821] Merge branch 'for-next' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
git bisect bad 21b9e91ad0d8b7af26c672e73f02f786580d0821
# bad: [c33b43555a71ff56ab56b4e6a6d7af564b1f471f] Merge branch 'perf-tools-=
next' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next=
=2Egit
git bisect bad c33b43555a71ff56ab56b4e6a6d7af564b1f471f
# bad: [9571d285ee2a042d4c23def223a5821d928e3cb2] Merge branch 'for-next' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
git bisect bad 9571d285ee2a042d4c23def223a5821d928e3cb2
# bad: [f122ed30288bc440d16c3daeb80295c666aabe29] Merge branch 'fs-next' of=
 linux-next
git bisect bad f122ed30288bc440d16c3daeb80295c666aabe29
# bad: [f9d0f6a766b047038cbda245074792176ac5ab19] Merge branch 'next' of ht=
tps://git.linaro.org/people/jens.wiklander/linux-tee.git
git bisect bad f9d0f6a766b047038cbda245074792176ac5ab19
# bad: [2a99396016d983cc7ed3d0bffda1478bc07d5bec] Merge branch 'for-next' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect bad 2a99396016d983cc7ed3d0bffda1478bc07d5bec
# bad: [c33b43555a71ff56ab56b4e6a6d7af564b1f471f] Merge branch 'perf-tools-=
next' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next=
=2Egit
git bisect bad c33b43555a71ff56ab56b4e6a6d7af564b1f471f
# bad: [5aad1c83f92277e7ce9fe8793d42c388514638e2] foo
git bisect bad 5aad1c83f92277e7ce9fe8793d42c388514638e2
# bad: [8d9b729b3438703296d4a4f9ccc632dcb799056c] selftests/mm: add tests f=
or folio_split(), buddy allocator like split
git bisect bad 8d9b729b3438703296d4a4f9ccc632dcb799056c
# good: [3f655316878130a97f835c3712346cbb4a80f990] mm/damon/sysfs-schemes: =
return error when for attempts to install filters on wrong sysfs directory
git bisect good 3f655316878130a97f835c3712346cbb4a80f990
# bad: [bcab1e6f685b1ad5a689bdc74d44d48c2c2738d2] mm/damon/sysfs: remove da=
mon_sysfs_cmd_request_callback() and its callers
git bisect bad bcab1e6f685b1ad5a689bdc74d44d48c2c2738d2
# good: [03d1f3409023bcf340e2090d05b2ac4ae606c41b] s390: make setup_zero_pa=
ges() use memblock
git bisect good 03d1f3409023bcf340e2090d05b2ac4ae606c41b
# bad: [7fc29589c8529696ad1349b14afc23284f1aecee] arch, mm: make releasing =
of memory to page allocator more explicit
git bisect bad 7fc29589c8529696ad1349b14afc23284f1aecee
# bad: [fe7e7f9c702bf45fb8a14c47099b3766a6fc7c39] arch, mm: set high_memory=
 in free_area_init()
git bisect bad fe7e7f9c702bf45fb8a14c47099b3766a6fc7c39
# good: [20ffecb95d1cfe7fd89208ec3783c23d56307e22] arch, mm: set max_mapnr =
when allocating memory map for FLATMEM
git bisect good 20ffecb95d1cfe7fd89208ec3783c23d56307e22
# first bad commit: [fe7e7f9c702bf45fb8a14c47099b3766a6fc7c39] arch, mm: se=
t high_memory in free_area_init()

--CW3GEQDFsKL6WAUW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfQeAkACgkQJNaLcl1U
h9CdOQf/auJHoL2AI0TUec5lBjLkY8y+H6ifxz/PfR7TNmbadKxW1YJ+ncXu8LTc
GzqSICsTkipvLyMhLSDAgIc8xf4NRiHGXiArmAAyFUgMrHpngS6DbxrCTZDz2X0e
1EzGtZ2pBwozKosXTqPyt3CxWzf2djrjkM4llnhH1Y/LT0Z1kL8qGIwUhEFRtt/p
6AjbX/W+L5WeY3dCWPNjFcBbucEmAlPMFgwTioXOw8KF3J8S5IeeUrWUXF7Itq1w
CFkvH76St1bHpw80chm+qf0DFKUFjNYXT1zsNDchz67yZJeSLjisA6mFrVkf3ZxA
TaHl7UhtB2Ia8q2bLAEJgK2w637hgQ==
=fjEk
-----END PGP SIGNATURE-----

--CW3GEQDFsKL6WAUW--

